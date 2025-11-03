// lib/services/report_service.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Keep these imports — they’re harmless now and ready for later
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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

      // 🔹 Start the upload
      final uploadTask = ref.putFile(file);

      // 🔹 Listen to progress (optional — you can print or update UI)
      uploadTask.snapshotEvents.listen((event) {
        final progress = event.bytesTransferred / event.totalBytes;
        debugPrint(
          'Uploading ${file.path.split('/').last}: ${(progress * 100).toStringAsFixed(1)}%',
        );
      });

      // 🔹 Wait until upload finishes
      final snap = await uploadTask.whenComplete(() => null);

      // 🔹 Get the download URL
      final url = await snap.ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
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
        'type': type,
        'title': title,
        'description': description,
        'category': category,
        'images': imageUrls,
        'location': location,
        'address': address,
        'status': 'ongoing',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
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
