import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/views/pages/forgot_password_page.dart';
import 'package:wujed/views/pages/signup_page.dart';
import 'package:wujed/views/widget_tree.dart';
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
    controllerEmail.addListener(updateButtonColor);
    controllerPassword.addListener(updateButtonColor);
  }

  TextEditingController controllerEmail = TextEditingController(text: '123');
  TextEditingController controllerPassword = TextEditingController(text: '456');
  String confirmedEmail = '123';
  String confirmedPassword = '456';

  String? textKey;
  Color textColor = Colors.grey.shade600;
  Color loginBtnColor = Colors.grey.shade400;

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                ),

                const SizedBox(height: 50.0),

                TextField(
                  controller: controllerEmail,
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
                  onEditingComplete: () => setState(() {}),
                ),

                const SizedBox(height: 30.0),

                TextField(
                  controller: controllerPassword,
                  autocorrect: false,
                  obscureText: hidePassword,
                  obscuringCharacter: '*',
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
                  onEditingComplete: () => setState(() {}),
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
                  onPressed: onLoginPressed,
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
                      child: Divider(color: Colors.grey.shade400, thickness: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        t.common_or,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey.shade400, thickness: 1),
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
    );
  }

  void updateButtonColor() {
    final filled =
        controllerEmail.text.trim().isNotEmpty &&
        controllerPassword.text.isNotEmpty;

    setState(() {
      loginBtnColor = filled
          ? const Color.fromRGBO(46, 23, 21, 1)
          : Colors.grey.shade400;
    });
  }

  void onLoginPressed() {
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        textKey = "login_error_fill_all";
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
    } else {
      if (email == confirmedEmail && password == confirmedPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WidgetTree()),
        );
      } else {
        setState(() {
          textKey = "login_error_invalid";
          textColor = const Color.fromRGBO(211, 47, 47, 1);
        });
      }
    }
  }

  String _resolveText(AppLocalizations t, String key) {
    switch (key) {
      case "login_error_fill_all":
        return t.login_error_fill_all;
      case "login_error_invalid":
        return t.login_error_invalid;
      default:
        return "";
    }
  }
}
