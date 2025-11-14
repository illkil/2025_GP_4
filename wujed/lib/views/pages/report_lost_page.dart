import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wujed/views/pages/pick_location_page.dart';
import 'package:wujed/views/pages/submit_successfully_page.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wujed/services/report_service.dart';
import 'package:flutter/services.dart';

class ReportLostPage extends StatefulWidget {
  const ReportLostPage({super.key});

  @override
  State<ReportLostPage> createState() => _ReportLostPageState();
}

class _ReportLostPageState extends State<ReportLostPage> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  Color textColor = Colors.grey.shade600;
  Widget? uploadPhoto;

  final int _maxLength = 300;
  bool isSubmitting = false;

  //final _picker = ImagePicker();
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
      body: Stack(
        children: [
          FocusScope(
            node: FocusScopeNode(),
            autofocus: false,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
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
                        t.report_lost_title,
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
                        maxLength: 30,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(
                              r'[a-zA-Z0-9\u0660-\u0669\u0621-\u064A\u064B-\u0652\u0640\s]',
                            ),
                          ),
                        ],
                        decoration: InputDecoration(
                          hintText: t.report_title_hint,
                          counterText: '',
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
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),

                      const SizedBox(height: 20.0),

                      _buildLabel(t.report_photo_label, required: true),

                      const SizedBox(height: 10.0),

                      if (_images.length < 2) buildUploadButton(),
                      const SizedBox(height: 15.0),
                      if (_images.isNotEmpty) _buildImagesPreview(),

                      const SizedBox(height: 20.0),

                      _buildLabel(t.report_location_label),

                      const SizedBox(height: 10.0),

                      OutlinedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PickLocationPage(),
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
                                (_maxLength -
                                        controllerDescription.text.length) <=
                                    0
                                ? Colors.red
                                : Colors.grey.shade400,
                          ),
                        ),
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                      ),

                      const SizedBox(height: 30.0),

                      FilledButton(
                        onPressed: _submitting
                            ? null
                            : () => _submitLostReport(t),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: const Color.fromRGBO(46, 23, 21, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          _submitting
                              ? t.report_submitting
                              : t.report_submit_button,
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
          ),
          if (isSubmitting) //wait for report to submit
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              child: Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 175, 0, 1),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pickImages() async {
    final t = AppLocalizations.of(context);
    FocusScope.of(context).unfocus();

    final hasPermission = await _requestPhotoPermission();
    if (!hasPermission) {
      _showSnackBar(t.error_allow_photo_access, Icons.warning_rounded);
      return;
    }

    //limit to 2 total images
    final remainingSlots = 2 - _images.length;
    if (remainingSlots <= 0) {
      _showSnackBar(t.error_max_photos, Icons.warning_rounded);
      return;
    }

    final result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: remainingSlots,
        requestType: RequestType.image,
        specialItemPosition: SpecialItemPosition.prepend,
        specialItemBuilder: (context, _, __) {
          return GestureDetector(
            onTap: () async {
              final picker = ImagePicker();
              final picked = await picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 85,
              );
              if (picked != null) {
                final file = File(picked.path);

                try {
                  //save to user’s gallery
                  final bytes = await file
                      .readAsBytes(); // your camera image bytes

                  // Save temporarily before passing to GallerySaver
                  final tempDir = await getTemporaryDirectory();
                  final tempPath =
                      '${tempDir.path}/wujed_${DateTime.now().millisecondsSinceEpoch}.jpg';
                  final tempFile = await File(tempPath).writeAsBytes(bytes);

                  // Now save the temp file to the gallery
                  await GallerySaver.saveImage(tempFile.path);

                  setState(() {
                    if (_images.length < 2) {
                      _images.add(file);
                    }
                  });

                  Navigator.pop(context); //close picker after taking photo
                } catch (e) {
                  _showSnackBar(t.error_save_gallery, Icons.warning_rounded);
                }
              }
            },
            child: const Center(
              child: Icon(Icons.camera_alt, size: 42, color: Colors.grey),
            ),
          );
        },
      ),
    );

    if (result != null && result.isNotEmpty) {
      //convert to files
      final newFiles = await Future.wait(
        result.map((asset) async => await asset.file),
      );

      setState(() {
        for (final file in newFiles) {
          //prevent duplicates by comparing absolute file paths
          if (!_images.any((existing) => existing.path == file!.path)) {
            _images.add(file!);
          } else {
            _showSnackBar(t.error_duplicate_photo, Icons.warning_rounded);
          }
        }

        //ensure we never exceed 2 images
        if (_images.length > 2) {
          _images = _images.take(2).toList();
        }
      });
    }
  }

  Future<bool> _requestPhotoPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    final t = AppLocalizations.of(context);

    if (ps.isAuth) {
      //permission already granted
      return true;
    } else if (ps.hasAccess) {
      //old Android versions (pre-13) still valid
      return true;
    } else {
      //permission denied then open settings
      _showSnackBar(t.error_enable_photo_access, Icons.warning_rounded);
      await PhotoManager.openSetting();
      return false;
    }
  }

  Widget _buildImagesPreview() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        children: List.generate(_images.length, (i) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  _images[i],
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                top: 5,
                end: 5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _images.removeAt(i);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
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
      onPressed: () => _pickImages(),
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

  Future<void> _submitLostReport(AppLocalizations t) async {
    final title = controllerTitle.text.trim();
    final description = controllerDescription.text.trim();
    final t = AppLocalizations.of(context);

    if (title.isEmpty || description.isEmpty) {
      _showSnackBar(t.snackbar_fill_fields, Icons.warning_rounded);
      return;
    }

    if (_images.isEmpty) {
      _showSnackBar(t.snackbar_add_photos, Icons.warning_rounded);
      return;
    }

    setState(() => _submitting = true);
    try {
      setState(() {
        isSubmitting = true;
      });

      final result = await ReportService().createReport(
        type: 'lost',
        title: title,
        description: description,
        category: null,
        location: _geo,
        address: _address,
        imageFiles: _images,
      );

      setState(() {
        isSubmitting = false;
      });

      if (result == 'Failed-creating-report') {
        _showSnackBar(t.error_create_report, Icons.warning_rounded);
        setState(() {
          isSubmitting = false;
        });
        return;
      }

      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SubmitSuccessfullyPage()),
        (_) => false,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isSubmitting = false;
      });
      _showSnackBar(t.error_submit_report, Icons.warning_rounded);
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
          isSubmitting = false;
        });
      }
    }
  }

  void _showSnackBar(String message, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Color.fromRGBO(46, 23, 21, 1)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromRGBO(46, 23, 21, 1),
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

  void onSubmitPressed() {
    final title = controllerTitle.text.trim();
    final description = controllerDescription.text;

    if (title.isEmpty || description.isEmpty) {
      setState(() {
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SubmitSuccessfullyPage()),
        (route) => false,
      );
    }
  }
}
