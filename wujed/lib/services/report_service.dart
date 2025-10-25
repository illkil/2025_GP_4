// lib/services/report_service.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Keep these imports — they’re harmless now and ready for later
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/// Toggle this to re-enable Storage later when billing is on.
const bool kUseStorage = false;

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

  Future<List<String>> _uploadImages(String reportId, List<File> files) async {
    if (!kUseStorage) {
      // Dev mode: no uploads; return placeholders (or [] if you prefer)
      return List<String>.from(kDevPlaceholderImages);
    }

    final urls = <String>[];
    for (final file in files) {
      final name = const Uuid().v4();
      final ref = _storage.ref('reports/$reportId/images/$name.jpg');
      final snap = await ref.putFile(file);
      urls.add(await snap.ref.getDownloadURL());
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
    String? lang,
    List<File> imageFiles = const [],
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Not signed in');

    // Create the doc first to get an ID
    final doc = _db.collection('reports').doc();
    await doc.set({
      'ownerUid': user.uid,
      'type': type,
      'title': title,
      'description': description,
      'category': category,
      'images': [], // filled below
      'location': location,
      'address': address,
      'locationText': FieldValue.delete(),
      'status': 'ongoing',
      'lang': lang,
      'is_flagged': false,
      'flagg_reason': [],
      'flag_created_at': '',
      'visibility': 'private',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'devStorage': !kUseStorage, // helpful flag to know these are placeholders
    }, SetOptions(merge: true));

    // Will return placeholders when kUseStorage == false
    final urls = await _uploadImages(doc.id, imageFiles);

    await doc.update({
      'images': urls,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return doc.id;
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
