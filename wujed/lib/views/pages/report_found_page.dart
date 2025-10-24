import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/views/pages/pick_location_page.dart';
import 'package:wujed/views/pages/submit_successfully_page.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wujed/services/report_service.dart';
import 'package:flutter/services.dart';

class ReportFoundPage extends StatefulWidget {
  const ReportFoundPage({super.key});

  @override
  State<ReportFoundPage> createState() => _ReportFoundPageState();
}

class _ReportFoundPageState extends State<ReportFoundPage> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  Color textColor = Colors.grey.shade600;
  Widget? uploadPhoto;

  final int _maxLength = 300;
  final _picker = ImagePicker();
  List<File> _images = [];
  GeoPoint? _geo;
  String? _address;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    controllerDescription.addListener(() {
      setState(() {});
    });
    controllerTitle.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    uploadPhoto ??= buildUploadButton();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50.0),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      color: const Color.fromRGBO(46, 23, 21, 1),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Text(
                  t.report_found_title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  t.report_required_details,
                  style: TextStyle(fontSize: 16.0, color: textColor),
                ),
                const SizedBox(height: 40.0),
                _buildLabel(t.report_title_label, required: true),
                const SizedBox(height: 10.0),
                TextField(
                  controller: controllerTitle,
                  autocorrect: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r'[a-zA-Z0-9\u0660-\u0669\u0621-\u064A\u064B-\u0652\u0640\s]',
                      ),
                    ),
                  ],

                  decoration: InputDecoration(
                    hintText: t.report_title_hint,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        width: 2.0,
                      ),
                    ),
                  ),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
                const SizedBox(height: 20.0),
                _buildLabel(t.report_photo_label, required: true),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildUploadButton(),
                    const SizedBox(height: 10),
                    _imagesPreview(),
                  ],
                ),
                const SizedBox(height: 20.0),
                _buildLabel(t.report_location_label, required: true),
                const SizedBox(height: 10.0),
                OutlinedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PickLocationPage(),
                      ),
                    );

                    if (result is Map &&
                        result['lat'] != null &&
                        result['lng'] != null) {
                      setState(() {
                        _geo = GeoPoint(
                          (result['lat'] as num).toDouble(),
                          (result['lng'] as num).toDouble(),
                        );
                        _address = (result['address'] as String?)
                            ?.split(',')
                            .take(2)
                            .join(', ');
                      });

                      _showSnackBar(
                        t.snackbar_location_set,
                        Icons.check_circle,
                      );
                    } else {
                      _showSnackBar(
                        t.snackbar_location_not_selected,
                        Icons.warning,
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: SizedBox(
                    height: 55.0,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        const PositionedDirectional(
                          top: 0,
                          bottom: 0,
                          child: Icon(
                            IconlyBold.location,
                            color: Color.fromRGBO(46, 23, 21, 1),
                            size: 37,
                          ),
                        ),
                        PositionedDirectional(
                          top: 17,
                          start: 70,
                          child: Text(
                            _address ?? t.report_location_button_hint,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildLabel(t.report_description_label, required: true),
                const SizedBox(height: 10.0),
                TextField(
                  controller: controllerDescription,
                  autocorrect: false,
                  maxLength: _maxLength,
                  maxLines: 6,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r'[a-zA-Z0-9\u0660-\u0669\u0621-\u064A\u064B-\u0652\u0640\s]',
                      ),
                    ),
                  ],

                  decoration: InputDecoration(
                    hintText: t.report_description_hint,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        width: 2.0,
                      ),
                    ),
                    counterText: t.report_counter_left(
                      _maxLength - controllerDescription.text.length,
                    ),
                    counterStyle: TextStyle(
                      fontSize: 12,
                      color:
                          (_maxLength - controllerDescription.text.length) <= 0
                          ? Colors.red
                          : Colors.grey.shade400,
                    ),
                  ),
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
                const SizedBox(height: 30.0),
                FilledButton(
                  onPressed: _submitting
                      ? null
                      : () => _submitFoundReport(
                          title: controllerTitle.text,
                          description: controllerDescription.text,
                          t: t,
                        ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color.fromRGBO(46, 23, 21, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _submitting ? t.report_submitting : t.report_submit_button,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final picks = await _picker.pickMultiImage(imageQuality: 85);
    if (picks.isEmpty) return;
    setState(() {
      _images = picks.map((x) => File(x.path)).toList();
    });
  }

  Widget _imagesPreview() {
    if (_images.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            _images[i],
            height: 160,
            width: 160,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<void> _submitFoundReport({
    required String title,
    required String description,
    required AppLocalizations t,
    String? category,
  }) async {
    if (_submitting) return;
    if (title.trim().isEmpty || description.trim().isEmpty) {
      _showSnackBar(t.snackbar_fill_fields, Icons.warning);
      return;
    }
    if (_geo == null) {
      _showSnackBar(t.snackbar_pick_location, Icons.warning);
      return;
    }

    setState(() => _submitting = true);
    try {
      await ReportService().createReport(
        type: 'found',
        title: title.trim(),
        description: description.trim(),
        category: category,
        location: _geo,
        address: _address,
        lang: 'en',
        imageFiles: _images,
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SubmitSuccessfullyPage()),
      );
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(t.snackbar_submit_failed(e.toString()), Icons.error);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showSnackBar(String message, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFE4B3),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
      ),
    );
  }

  Widget _buildLabel(String text, {bool required = false}) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Color.fromRGBO(43, 23, 21, 1),
            fontSize: 16,
          ),
        ),
        if (required)
          const Text(
            '*',
            style: TextStyle(
              color: Color.fromRGBO(211, 47, 47, 1),
              fontSize: 16,
            ),
          ),
      ],
    );
  }

  Widget buildUploadButton() {
    final t = AppLocalizations.of(context);
    return OutlinedButton(
      onPressed: _pickImages,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: SizedBox(
        height: 55.0,
        width: double.infinity,
        child: Stack(
          children: [
            const PositionedDirectional(
              top: 0,
              bottom: 0,
              child: Icon(
                IconlyBold.camera,
                color: Color.fromRGBO(46, 23, 21, 1),
                size: 37,
              ),
            ),
            PositionedDirectional(
              top: 17,
              start: 60,
              child: Text(
                t.report_upload_photos_hint,
                style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
