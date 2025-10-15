import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/auth/main_page.dart';
import 'package:wujed/views/pages/forgot_password_page.dart';
import 'package:wujed/views/pages/signup_page.dart';
import 'package:wujed/widgets/google_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _controllerEmail.addListener(updateButtonColor);
    _controllerPassword.addListener(updateButtonColor);
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String? textKey;
  Color textColor = Colors.grey.shade600;
  Color loginBtnColor = Colors.grey.shade400;

  bool hidePassword = true;
  bool isLocked = false;
  DateTime? lockEndTime;

  Future onLogin() async {
    final email = _controllerEmail.text.trim().toLowerCase();
    final password = _controllerPassword.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        textKey = "login_error_fill_all";
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }

    if (isLocked) {
      setState(() {
        textKey = "login_locked";
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'wrong-password' ||
          e.code == 'invalid-email' ||
          e.code == 'invalid-credential') {
        message = 'login_error_invalid';
      } else if (e.code == 'too-many-requests') {
        message = 'login_error_too_many_attepmts';

        setState(() {
          isLocked = true;
          lockEndTime = DateTime.now().add(const Duration(minutes: 3));
        });

        Future.delayed(const Duration(minutes: 3), () {
          setState(() {
            isLocked = false;
          });
        });
      } else {
        message = 'login_error_failed';
      }

      setState(() {
        textKey = message;
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
    }
  }

  @override
  void dispose() {
    _controllerEmail;
    _controllerPassword;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.login_title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      color: Color.fromRGBO(46, 23, 21, 1),
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  Text(
                    textKey != null
                        ? _resolveText(t, textKey!)
                        : t.login_subtitle,
                    style: TextStyle(fontSize: 16.0, color: textColor),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 50.0),

                  TextField(
                    controller: _controllerEmail,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: t.login_email_label,
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
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),

                  const SizedBox(height: 30.0),

                  TextField(
                    controller: _controllerPassword,
                    autocorrect: false,
                    obscureText: hidePassword,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: t.login_password_label,
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
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => hidePassword = !hidePassword),
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          t.login_forgot_password,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1,
                            decorationColor: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Image.asset('lib/assets/images/reCAPTCHA.png', width: 400),

                  const SizedBox(height: 30.0),

                  FilledButton(
                    onPressed: () async {
                      await onLogin();
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: loginBtnColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      t.login_button,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.login_no_account,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          t.login_signup_link,
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 111, 255, 1),
                            decoration: TextDecoration.underline,
                            decorationThickness: 1,
                            decorationColor: Color.fromRGBO(0, 111, 255, 1),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10.0),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          t.common_or,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20.0),

                  GsiMaterialButton(onPressed: () {}, text: t.google_continue),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateButtonColor() {
    final filled =
        _controllerEmail.text.trim().isNotEmpty &&
        _controllerPassword.text.isNotEmpty;

    setState(() {
      loginBtnColor = filled
          ? const Color.fromRGBO(46, 23, 21, 1)
          : Colors.grey.shade400;
    });
  }

  String _resolveText(AppLocalizations t, String key) {
    switch (key) {
      case "login_error_fill_all":
        return t.login_error_fill_all;
      case "login_error_invalid":
        return t.login_error_invalid;
      case "login_error_too_many_attepmts":
        return t.login_error_too_many_attepmts;
      case "login_error_failed":
        return t.login_error_failed;
      case "login_locked":
        final remaining = lockEndTime!.difference(DateTime.now()).inSeconds;
        return t.login_locked(remaining);
      default:
        return t.login_subtitle;
    }
  }
}
