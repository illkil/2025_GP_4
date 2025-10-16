import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<File> assetToTempFile(String assetPath, {String? filename}) async {
  print('🔎 Loading asset: $assetPath');
  final data = await rootBundle.load(assetPath);                     // throws if asset missing
  final bytes = data.buffer.asUint8List();
  print('✅ Asset bytes: ${bytes.length}');

  final dir = await getTemporaryDirectory();
  final name = filename ?? assetPath.split('/').last;
  final file = File('${dir.path}/$name');
  await file.writeAsBytes(bytes, flush: true);

  final exists = await file.exists();
  final len = await file.length();
  print('✅ Wrote temp file: ${file.path} (exists=$exists, bytes=$len)');
  return file;
}
