// lib/services/report_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Keep these imports — they’re harmless now and ready for later
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

/// Toggle this to re-enable Storage later when billing is on.
// const bool kUseStorage = false;

/// Optional: placeholder images so UI looks real without Storage.
const List<String> kDevPlaceholderImages = <String>[
  'https://picsum.photos/seed/wujed1/800/600',
  'https://picsum.photos/seed/wujed2/800/600',
];

class ReportService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // Ready for later when you turn Storage back on. Not used while kUseStorage=false.
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> _uploadImages(
    String type,
    String reportId,
    List<File> files,
  ) async {
    // if (!kUseStorage) {
    //   // Dev mode: no uploads; return placeholders (or [] if you prefer)
    //   return List<String>.from(kDevPlaceholderImages);
    // }

    final urls = <String>[];
    for (final file in files) {
      final name = const Uuid().v4();
      final ref = _storage.ref('reports/$type/$reportId/images/$name.jpg');
      final snap = await ref.putFile(file);
      urls.add(await snap.ref.getDownloadURL());
    }
    return urls;
  }

  // Changed return type to Map so we can access:
  // accepted, reason, category, labels, imageDetails
  Future<Map<String, dynamic>?> classifyItem(
    String type, // send report type to implement the logic
    List<String> imageUrls,
    String description,
  ) async {
    final uri = Uri.parse(
      "https://wujed-classifier-1031003478013.us-central1.run.app/classify",
    ); //link of deployed fast api model server to cloud run

    final response = await http.post(
      //make post request to send to the fastapi server (u must turn it on in your device)
      uri,
      headers: {
        "Content-Type": "application/json",
      }, //we are sending a json file
      body: jsonEncode({
        "type": type, // backend now requires report type lost/found
        "image_urls": imageUrls,
        "description": description,
      }), //the data that we defined in the model
    );

    if (response.statusCode == 200) {
      //200 means server responded successfully
      final data =
          jsonDecode(response.body)
              as Map<
                String,
                dynamic
              >; //convert response JSON to a Map<String, dynamic>
      return data; //now returns the full classification result (accepted, reason, category, labels, imageDetails)
    } else {
      return null; //if server didnt respond successfully then return the category as null (since it failed processing mean that we will try again soon)
    }
  }

  /// Create a LOST or FOUND report. Returns the new doc id.
  Future<String> createReport({
    required String type, // 'lost' | 'found'
    required String title,
    required String description,
    String? category,
    GeoPoint? location,
    String? address,
    List<File> imageFiles = const [],
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Not signed in');

    final reportId = const Uuid().v4();

    try {
      // 1️⃣ Upload all images first
      final imageUrls = await _uploadImages(type, reportId, imageFiles);

      // 2️⃣ Only after success → write to Firestore
      await _db.collection('reports').doc(reportId).set({
        'ownerUid': user.uid,
        'reportID': reportId,
        'type': type,
        'title': title,
        'description': description,
        'images': imageUrls,
        'location': location,
        'address': address,
        'status': 'ongoing',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'expiresAt': null,
      });

      Future(() async {
        //made it as future so it will not take so long for the report to be submitted, without it it will force the user to wait for the category to be selected by the model first which take some time
        final result = await classifyItem(
          type,
          imageUrls,
          description,
        ); // we send the information to the method above, to get the category and other data mentioned above the method.

        if (result == null) {
          // classification failed -> keep category as null
          // cloud Function can still retry later based on category == null
          return;
        }
        /*if (predictedCategory == 'processing' || predictedCategory.isEmpty) {
          //if categoraization was not successful try again after some time (5 seconds) if the second time is not successful then categorization will be done from cloud functions later (check functions/index.js)
          await Future.delayed(Duration(seconds: 5));
          predictedCategory = await classifyItem(imageUrls, description);
        }*/
        //if you want the retry in flutter too:
        /*if (result == null) {
          await Future.delayed(Duration(seconds: 3));
          final retry = await classifyItem(type, imageUrls, description);

          if (retry == null) {
            return; // let cloud function handle it
          }

          result = retry;
        } */

        //store if the report was accepted or not, and the reason if not (can be null).
        //reason is either junk description or no objects detected
        final bool accepted = result['accepted'] == true;
        final String? reason = result['reason'] as String?;

        //if report is rejected update status
        if (!accepted) {
          await _db.collection('reports').doc(reportId).update({
            'status': 'rejected',
            'rejectReason': reason,
            'updatedAt': FieldValue.serverTimestamp(),
          });
          return;
        }

        //stoer category even if empty
        String predictedCategory = (result['category'] ?? '') as String;

        //if the result is found but still category empty retry (extra step for caution)
        if (predictedCategory.isEmpty) {
          // no category returned category as null
          // Cloud Function can still retry based on category == null
          return;
        }

        await _db.collection('reports').doc(reportId).update({
          //update the report from firestore with the predected category
          'category': predictedCategory,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });

      return reportId;
    } catch (e) {
      return 'Failed-creating-report';
    }
  }

  /// Live list for the signed-in user's reports
  Stream<QuerySnapshot<Map<String, dynamic>>> myReportsStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _db
        .collection('reports')
        .where('ownerUid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> lostReportsStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _db
        .collection('reports')
        .where('ownerUid', isEqualTo: uid)
        .where('type', isEqualTo: 'lost')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> foundReportsStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _db
        .collection('reports')
        .where('ownerUid', isEqualTo: uid)
        .where('type', isEqualTo: 'found')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> ReportStream(String reportId) {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _db.collection('reports').doc(reportId).snapshots();
  }

  Future<void> deleteReport(String id) async {
    await _db.collection('reports').doc(id).delete();
  }
}
