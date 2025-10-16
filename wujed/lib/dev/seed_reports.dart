import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/report_service.dart';
import '../utils/asset_file.dart';

Future<String> seedLostReportFromAssets() async {
  final assets = [
    'lib/assets/images/BrownBag.JPG',
    'lib/assets/images/BrownBag2.JPEG',
  ];

  final files = <File>[];
  for (final a in assets) {
    final f = await assetToTempFile(a);
    print('📦 Prepared file for upload: ${f.path}');
    files.add(f);
  }

  final ksu = const GeoPoint(24.7169, 46.6236);

  print('🚀 Creating report…');
  final id = await ReportService().createReport(
    type: 'lost',
    title: 'Black laptop bag',
    description: 'Lost near King Saud University gate. Front pocket & brand tag.',
    category: 'bag',
    location: ksu,
    address: 'King Saud University, Riyadh',
    lang: 'en',
    imageFiles: files,
  );
  print('✅ Report created with id: $id');
  return id;
}
