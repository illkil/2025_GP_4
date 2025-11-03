import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/views/widget_tree.dart';

class SubmitSuccessfullyPage extends StatefulWidget {
  const SubmitSuccessfullyPage({super.key});

  @override
  State<SubmitSuccessfullyPage> createState() => _SubmitSuccessfullyPageState();
}

class _SubmitSuccessfullyPageState extends State<SubmitSuccessfullyPage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_rounded, size: 200, color: Color.fromRGBO(255, 204, 92, 1),),
            SizedBox(height: 40.0,),
            Text(
              t.report_sumbitted_successfully,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(46, 23, 21, 1),
              ), textAlign: TextAlign.center,
            ),
            SizedBox(height: 100.0,),
            FilledButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                  return WidgetTree();
                },), (route) => false);
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                t.btn_continue,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
