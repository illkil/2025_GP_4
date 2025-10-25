import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/auth/main_page.dart';
import 'package:wujed/views/pages/forgot_password_page.dart';
import 'package:wujed/views/pages/signup_page.dart';
import 'package:wujed/widgets/google_widget.dart';
import 'package:wujed/auth/google_auth.dart';

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
    _controllerEmail.addListener(
      validateEmail,
    ); //add listener for immediate error checking
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String? textKey;
  Color textColor = Colors.grey.shade600;
  Color loginBtnColor = Colors.grey.shade400;
  bool isLoading = false;
  String emailWarning = "";
  bool emailValid = false;

  bool hidePassword = true;
  bool isLocked = false; //to lock an account with too many log in attempts
  DateTime? lockEndTime; //variable for the lock timer

  Future onLogin() async {
    final t = AppLocalizations.of(context);
    setState(() {
      textKey = '';
      textColor = Colors.grey.shade600;
    });

    final email = _controllerEmail.text
        .trim()
        .toLowerCase(); //connected to email textfield controller
    final password = _controllerPassword.text
        .trim(); //same as above but password

    if (email.isEmpty || password.isEmpty) {
      //check if fields are empty
      setState(() {
        textKey = "login_error_fill_all";
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return; //return to not continue with the log in
    }

    if (isLocked) {
      //check if the account is on lock down because of too many log in attempts before continuing
      setState(() {
        textKey = "login_locked";
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }

    try {
      if (emailValid) {
        setState(() {
          isLoading = true;
        });

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              //signing in using email and password
              email: email,
              password: password,
            );

        final user = userCredential.user;

        if (user == null) {
          setState(() {
            isLoading = false;
            textKey = 'login_error_failed';
            textColor = const Color.fromRGBO(211, 47, 47, 1);
          });
          return;
        }

        setState(() {
          isLoading = false;
        });

        //User not verified then Log out and go to Login and give the option to resend the email
        if (!user.emailVerified) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  alignment: Alignment.center,
                  titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.login_email_not_verified,
                        style: const TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  content: Text(
                    t.login_email_verification_message,
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.end,
                  actions: [
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: const Color.fromRGBO(46, 23, 21, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        t.btn_continue,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        await user.sendEmailVerification();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        t.login_btn_resend,
                        style: const TextStyle(
                          color: const Color.fromRGBO(46, 23, 21, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          });
          return;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ), //Main page is at lib/auth/main_page.dart, it checks if there is a user logged in or not if yes it goes to home page (widget tree for navigation bar) if not it goes to loading page then intro pages then log in page as if it is a new user using the app
        );
      } else {
        throw FirebaseAuthException(code: 'invalid-email-format');
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'wrong-password' ||
          e.code == 'invalid-email' ||
          e.code == 'invalid-credential') {
        isLoading = false;
        message = 'login_error_invalid';
      } else if (e.code == 'invalid-email-format') {
        isLoading = false;
        emailWarning = t.signup_invalid_email_format;
        message = '';
      } else if (e.code == 'too-many-requests') {
        isLoading = false;
        message = 'login_error_too_many_attepmts';

        setState(() {
          isLocked = true; //lock the account for 3 minutes
          lockEndTime = DateTime.now().add(const Duration(minutes: 3));
        });

        Future.delayed(const Duration(minutes: 3), () {
          //unlock the account after 3 minutes
          setState(() {
            isLocked = false;
          });
        });
      } else {
        isLoading = false;
        message = 'login_error_failed';
      }

      setState(() {
        textKey = message; //this is the message bellow Welcome Back!
        textColor = message == ''
            ? Colors.grey.shade600
            : const Color.fromRGBO(211, 47, 47, 1);
      });
    }
  }

  @override
  void dispose() {
    //not used anymore so dispose
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@._]'),
                          ),
                        ],

                        keyboardType: TextInputType.emailAddress,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            emailWarning,
                            style: const TextStyle(
                              color: Color.fromRGBO(211, 47, 47, 1),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20.0),

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
                                  builder: (context) =>
                                      const ForgotPasswordPage(),
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

                      const SizedBox(height: 20.0),

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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
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

                      GsiMaterialButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final userCredential =
                              await GoogleSignInService.signInWithGoogle();
                          setState(() {
                            isLoading = false;
                          });
                          if (userCredential != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ),
                            );
                          }
                        },
                        text: t.google_continue,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          if (isLoading) //wait for user account to be created
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

  bool isValidEmail(String email) {
    //set only valid emails, which are gmail/outlook/hotmail/yahoo/icloud so user does not used not existing emails like ghaida@dhfjgjf.fhsjaf
    //this also inforce email format it must has @ and . (dot)
    final validEmailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return validEmailRegex.hasMatch(email);
  }

  void validateEmail() {
    //immediate error checking
    final email = _controllerEmail.text.trim().toLowerCase();
    final t = AppLocalizations.of(context);

    if (email.isEmpty) {
      setState(() {
        emailWarning = '';
        emailValid = false;
      });
      return;
    }

    if (!isValidEmail(email)) {
      setState(() {
        emailWarning = t.signup_invalid_email_format;
        emailValid = false;
      });
      return;
    } else {
      setState(() {
        emailWarning = '';
        emailValid = true;
      });
    }

    setState(() {
      emailValid = true;
    });
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
