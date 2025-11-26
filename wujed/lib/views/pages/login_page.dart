import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/auth/main_page.dart';
import 'package:wujed/views/pages/forgot_password_page.dart';
import 'package:wujed/views/pages/signup_page.dart';
import 'package:wujed/widgets/google_widget.dart';
import 'package:wujed/auth/google_auth.dart';

// ✅ Shared sanitising + validators
import 'package:wujed/utils/input_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ✅ Form key to validate all TextFormFields together
  final _formKey = GlobalKey<FormState>();

  // Controllers for the email + password text fields
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // Key to pick which localized text to show under "Welcome back!"
  String? textKey;
  Color textColor = Colors.grey.shade600;

  // Colors for the login button (enabled/disabled)
  Color loginBtnColor = Colors.grey.shade400;

  bool isLoading = false;

  // Live email validation warning under the email field
  String emailWarning = "";
  bool emailValid = false;

  bool hidePassword = true;

  // Account lock state (too many login attempts)
  bool isLocked = false;
  DateTime? lockEndTime;

  @override
  void initState() {
    super.initState();
    // Whenever text changes, update button color
    _controllerEmail.addListener(updateButtonColor);
    _controllerPassword.addListener(updateButtonColor);

    // Live validation of email while typing
    _controllerEmail.addListener(validateEmail);
  }

  @override
  void dispose() {
    // Dispose controllers when widget is removed
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // LOGIN LOGIC
  // ---------------------------------------------------------------------------
  Future onLogin() async {
    final t = AppLocalizations.of(context);

    // Reset subtitle message before starting
    setState(() {
      textKey = '';
      textColor = Colors.grey.shade600;
    });

    // 1) Run Form validation (TextFormField validators)
    if (!_formKey.currentState!.validate()) {
      // If a validator returns an error, we stop here.
      print("❌ LOGIN FORM VALIDATION FAILED");
      return;
    }

    // 2) SANITISE INPUT BEFORE USING IT
    //
    // Email:
    //  - trimmed
    //  - max length limited
    //  - < and > removed
    //  - lowercased for consistency
    final email = InputValidators.sanitizeText(
      _controllerEmail.text,
      maxLen: 100,
    ).toLowerCase();

    // Password:
    //  - only trim spaces around, we don't remove characters
    final password = _controllerPassword.text.trim();

    // 3) Extra check (redundant with validators but safe + easy to understand)
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        textKey = "login_error_fill_all";
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }

    // 4) Check if account is currently locked (too many attempts)
    if (isLocked) {
      setState(() {
        textKey = "login_locked";
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }

    try {
      // Only attempt sign-in if email format was validated by validateEmail()
      if (emailValid) {
        setState(() {
          isLoading = true;
        });

        // Firebase Auth: sign in with email + password
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = userCredential.user;

        // If somehow no user returned (shouldn't happen, but safe to check)
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

        // If the user has not verified their email yet
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
                          color: Color.fromRGBO(46, 23, 21, 1),
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

        // If everything is ok → go to MainPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      } else {
        // If emailValid is false, we throw a custom error so we can show a nice message
        throw FirebaseAuthException(code: 'invalid-email-format');
      }
    } on FirebaseAuthException catch (e) {
      final t = AppLocalizations.of(context);

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

        // Lock the account for 3 minutes
        setState(() {
          isLocked = true;
          lockEndTime = DateTime.now().add(const Duration(minutes: 3));
        });

        // After 3 minutes, unlock again
        Future.delayed(const Duration(minutes: 3), () {
          setState(() {
            isLocked = false;
          });
        });
      } else {
        isLoading = false;
        message = 'login_error_failed';
      }

      setState(() {
        // textKey selects which localized message to show under "Welcome Back!"
        textKey = message;
        textColor = message == ''
            ? Colors.grey.shade600
            : const Color.fromRGBO(211, 47, 47, 1);
      });
    }
  }

  // ---------------------------------------------------------------------------
  // BUILD UI
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
            // Hide keyboard when tapping outside fields
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  // ✅ Wrap fields in a Form so we can use validators
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // "Welcome back" title
                        Text(
                          t.login_title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                            color: Color.fromRGBO(46, 23, 21, 1),
                          ),
                        ),

                        const SizedBox(height: 10.0),

                        // Subtitle / dynamic messages based on textKey
                        Text(
                          textKey != null
                              ? _resolveText(t, textKey!)
                              : t.login_subtitle,
                          style: TextStyle(fontSize: 16.0, color: textColor),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 50.0),

                        // ---------------------------------------------------
                        // EMAIL FIELD (TextFormField + validator)
                        // ---------------------------------------------------
                        TextFormField(
                          controller: _controllerEmail,
                          autocorrect: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@._\-]'),
                            ),
                          ],
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: t.login_email_label,
                            labelStyle: const TextStyle(fontSize: 16.0),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always,
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
                          // Simple Form-level validator:
                          //  - we just ensure it is not empty
                          //  - detailed format is handled in validateEmail()
                          validator: (value) {
                            final v = value?.trim() ?? '';
                            if (v.isEmpty) {
                              return;
                            }
                            return null;
                          },
                        ),

                        // Live email warning under the field
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

                        // ---------------------------------------------------
                        // PASSWORD FIELD (TextFormField + validator)
                        // ---------------------------------------------------
                        TextFormField(
                          controller: _controllerPassword,
                          autocorrect: false,
                          obscureText: hidePassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: t.login_password_label,
                            labelStyle: const TextStyle(fontSize: 16.0),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always,
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
                              onPressed: () => setState(
                                () => hidePassword = !hidePassword,
                              ),
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
                          // Just ensure the password is not empty
                          validator: (value) {
                            final v = value?.trim() ?? '';
                            if (v.isEmpty) {
                              return;
                            }
                            return null;
                          },
                        ),

                        // "Forgot password" link
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

                        // ---------------------------------------------------
                        // LOGIN BUTTON
                        // ---------------------------------------------------
                        FilledButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
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

                        // "Don't have an account? Sign up"
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
                                  decorationColor:
                                      Color.fromRGBO(0, 111, 255, 1),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //const SizedBox(height: 10.0),

                        // Divider with "or"
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Divider(
                        //         color: Colors.grey.shade400,
                        //         thickness: 1,
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //         horizontal: 8.0,
                        //       ),
                        //       child: Text(
                        //         t.common_or,
                        //         style: TextStyle(color: Colors.grey.shade600),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Divider(
                        //         color: Colors.grey.shade400,
                        //         thickness: 1,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // const SizedBox(height: 20.0),

                        // ---------------------------------------------------
                        // GOOGLE SIGN IN
                        // ---------------------------------------------------
                        // GsiMaterialButton(
                        //   onPressed: () async {
                        //     if (!mounted) return;
                        //     setState(() {
                        //       isLoading = true;
                        //     });
                        //     final userCredential =
                        //         await GoogleSignInService.signInWithGoogle();
                        //     if (!mounted) return;
                        //     setState(() {
                        //       isLoading = false;
                        //     });
                        //     if (userCredential != null) {
                        //       Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const MainPage(),
                        //         ),
                        //       );
                        //     }
                        //   },
                        //   text: t.google_continue,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Loading overlay while signing in
          if (isLoading)
            Container(
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 175, 0, 1),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LIVE EMAIL VALIDATION
  // ---------------------------------------------------------------------------

  bool isValidEmail(String email) {
    // Enforce valid email pattern (must have @ and .)
    final validEmailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return validEmailRegex.hasMatch(email);
  }

  void validateEmail() {
    // Immediate error checking while typing
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

  // ---------------------------------------------------------------------------
  // BUTTON COLOR HELPER
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // HELPER TO PICK THE RIGHT LOCALIZED ERROR MESSAGE
  // ---------------------------------------------------------------------------

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
        // Show remaining lockout time in seconds
        final remaining = lockEndTime!.difference(DateTime.now()).inSeconds;
        return t.login_locked(remaining);
      default:
        return t.login_subtitle;
    }
  }
}