import 'package:flutter/material.dart';
import 'package:wujed/views/pages/verify_page.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    super.initState();
    controllerEmail.addListener(updateButtonColor);
  }

  TextEditingController controllerEmail = TextEditingController();
  String confirmedEmail = '123';

  Color resetPasswordBtnColor = Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60.0),

              Text(
                t.forgot_title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),

              const SizedBox(height: 10.0),

              Text(
                t.forgot_subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 50.0),

              TextField(
                controller: controllerEmail,
                decoration: InputDecoration(
                  labelText: t.forgot_email_label,
                  labelStyle: const TextStyle(fontSize: 16.0),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
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

              const SizedBox(height: 30.0),

              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VerifyPage(),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: resetPasswordBtnColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  t.forgot_reset_button,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateButtonColor() {
    final filled = controllerEmail.text.trim().isNotEmpty;

    setState(() {
      resetPasswordBtnColor =
          filled ? const Color.fromRGBO(46, 23, 21, 1) : Colors.grey.shade400;
    });
  }
}
