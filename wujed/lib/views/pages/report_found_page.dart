import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/views/pages/pick_location_page.dart';
import 'package:wujed/views/pages/submit_successfully_page.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
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
                onEditingComplete: () => setState(() {}),
              ),

              const SizedBox(height: 20.0),

              _buildLabel(t.report_photo_label, required: true),

              const SizedBox(height: 10.0),

              uploadPhoto!,

              const SizedBox(height: 20.0),

              _buildLabel(t.report_location_label, required: true),

              const SizedBox(height: 10.0),

              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PickLocationPage(),
                    ),
                  );
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
                          t.report_location_button_hint,
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
                maxLength: _maxLength,
                maxLines: 6,
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
                    color: Colors.grey.shade400,
                  ),
                ),
                onChanged: (value) => setState(() {}),
              ),

              const SizedBox(height: 30.0),

              FilledButton(
                onPressed: () => onSubmitPressed(t),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color.fromRGBO(46, 23, 21, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  t.report_submit_button,
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
      onPressed: () => onUploadPhoto(),
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

  void onUploadPhoto() {
    setState(() {
      uploadPhoto = Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(0, 0, 0, 0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'lib/assets/images/CoffeeBrew.WEBP',
                height: 160,
                width: 160,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: -10,
            end: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromRGBO(46, 23, 21, 1),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: const Icon(
                  IconlyBold.camera,
                  color: Color.fromRGBO(46, 23, 21, 1),
                  size: 37,
                ),
                onPressed: () => onIconButtonPressed(),
              ),
            ),
          ),
        ],
      );
    });
  }

  void onIconButtonPressed() {
    setState(() {
      uploadPhoto = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(0, 0, 0, 0.2),
                width: 1,
              ),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                bottomStart: Radius.circular(20),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(17),
                bottomStart: Radius.circular(17),
              ),
              child: Image.asset(
                'lib/assets/images/CoffeeBrew.WEBP',
                height: 160,
                width: 160,
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(0, 0, 0, 0.2),
                width: 1,
              ),
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(17),
                bottomEnd: Radius.circular(17),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(20),
                bottomEnd: Radius.circular(20),
              ),
              child: Image.asset(
                'lib/assets/images/CoffeeBrew2.jpg',
                height: 160,
                width: 160,
              ),
            ),
          ),
        ],
      );
    });
  }

  void onSubmitPressed(AppLocalizations t) {
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
