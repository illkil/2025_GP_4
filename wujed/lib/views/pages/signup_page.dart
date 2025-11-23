import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wujed/auth/google_auth.dart';
import 'package:wujed/auth/main_page.dart';
import 'package:wujed/views/pages/login_page.dart';
import 'package:wujed/widgets/google_widget.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

// 🔒 Our shared validators + sanitiser
import 'package:wujed/utils/input_validators.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Global key to control the <Form> widget
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // UI state
  String text = '';
  String usernameWarning = "";
  String emailWarning = "";
  String weakPasswordWarning = "";
  Color textColor = Colors.grey.shade600;
  Color signupBtnColor = Colors.grey.shade400;

  bool hidePassword = true;
  bool is18OrOlder = false;
  bool isLoading = false;

  // Validation flags
  bool usernameValid = false;
  bool emailValid = false;
  bool passwordValid = false;

  // Timers for debouncing
  Timer? usernameTimer;
  Timer? emailTimer;

  @override
  void initState() {
    super.initState();

    _controllerUsername.addListener(updateButtonColor);
    _controllerEmail.addListener(updateButtonColor);
    _controllerPassword.addListener(updateButtonColor);

    _controllerUsername.addListener(validateUsername);
    _controllerEmail.addListener(validateEmail);
    _controllerPassword.addListener(validatePassword);
  }

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    usernameTimer?.cancel();
    emailTimer?.cancel();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // SIGNUP LOGIC
  // ---------------------------------------------------------------------------
  Future onSignup() async {
    final t = AppLocalizations.of(context);

    if (!_formKey.currentState!.validate()) {
      print("❌ FORM VALIDATION FAILED");
      return;
    }

    setState(() {
      text = t.signup_subtitle;
      textColor = Colors.grey.shade600;
    });

    // SANITIZE
    final username = InputValidators.sanitizeText(
      _controllerUsername.text,
      maxLen: 20,
    );

    final email = InputValidators
        .sanitizeText(_controllerEmail.text, maxLen: 100)
        .toLowerCase();

    final password = _controllerPassword.text.trim();

    // Final safety checks
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        text = t.login_error_fill_all;
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }

    if (!is18OrOlder) {
      setState(() {
        text = t.check_18yo_checkbox;
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }

    try {
      if (usernameValid && emailValid && passwordValid) {
        setState(() {
          isLoading = true;
        });

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = userCredential.user!;
        final prefs = await SharedPreferences.getInstance();
        final String? lang = prefs.getString('preferredLanguage');
        final firestore = FirebaseFirestore.instance;

        // ---------------------------------------------------------------------
        // ✅ FIRESTORE DOCUMENTS ACCORDING TO YOUR RULES
        // ---------------------------------------------------------------------
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('public')
            .doc('data')
            .set({
          'username': username,
          'profile_photo': '',
        });

        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('private')
            .doc('data')
            .set({
          'email': email,
          'first_name': '',
          'last_name': '',
          'phone_number': '',
          'language': lang ?? 'en',
          'created_at': Timestamp.now(),
        });

        // Update Firebase Auth displayName
        await user.updateDisplayName(username);
        await user.sendEmailVerification();

        setState(() => isLoading = false);

        // Dialog
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
              title: Center(
                child: Text(
                  t.signup_account_created_success,
                  style: const TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: Text(
                t.signup_email_verification_message,
                textAlign: TextAlign.center,
              ),
              actionsAlignment: MainAxisAlignment.end,
              actions: [
                FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
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
              ],
            );
          },
        );

        return;
      } else {
        throw FirebaseAuthException(code: 'all-detailes-must-be-valid');
      }
    } on FirebaseAuthException catch (e) {
      final t = AppLocalizations.of(context);

      if (e.code == 'email-already-in-use') {
        setState(() {
          emailWarning = t.signup_email_exists;
          isLoading = false;
        });
      } else if (e.code == 'all-detailes-must-be-valid') {
        setState(() {
          text = t.signup_all_details_valid;
          textColor = const Color.fromRGBO(211, 47, 47, 1);
          isLoading = false;
        });
      } else {
        setState(() {
          text = t.signup_failed;
          textColor = const Color.fromRGBO(211, 47, 47, 1);
          isLoading = false;
        });
      }
    }
  }

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    text = text.isEmpty ? t.signup_subtitle : text;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          t.signup_title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                          ),
                        ),

                        const SizedBox(height: 10.0),

                        Text(
                          text,
                          style: TextStyle(fontSize: 16.0, color: textColor),
                        ),

                        const SizedBox(height: 50.0),

                        // ---------------------------------------------------
                        // USERNAME
                        // ---------------------------------------------------
                        TextFormField(
                          controller: _controllerUsername,
                          autocorrect: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9._]'),
                            ),
                          ],
                          maxLength: 20,
                          decoration: InputDecoration(
                            counterText: '',
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
                          validator: (value) {
                            final v = value?.trim() ?? '';
                            if (v.isEmpty) return t.login_error_fill_all;
                            return null;
                          },
                        ),

                        Row(
                          children: [
                            Text(
                              usernameWarning,
                              style: const TextStyle(
                                color: Color.fromRGBO(211, 47, 47, 1),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ---------------------------------------------------
                        // EMAIL
                        // ---------------------------------------------------
                        TextFormField(
                          controller: _controllerEmail,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@._\-]'),
                            ),
                          ],
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
                          validator: (value) {
                            final v = value?.trim() ?? '';
                            if (v.isEmpty) return t.login_error_fill_all;
                            return null;
                          },
                        ),

                        Row(
                          children: [
                            Text(
                              emailWarning,
                              style: const TextStyle(
                                color: Color.fromRGBO(211, 47, 47, 1),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ---------------------------------------------------
                        // PASSWORD
                        // ---------------------------------------------------
                        TextFormField(
                          controller: _controllerPassword,
                          autocorrect: false,
                          obscureText: hidePassword,
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
                          
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                hidePassword = !hidePassword;
                              }),
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          validator: (value) {
                            final v = value?.trim() ?? '';
                            if (v.isEmpty) return t.login_error_fill_all;
                            return null;
                          },
                        ),

                        Row(
                          children: [
                            Text(
                              weakPasswordWarning,
                              style: const TextStyle(
                                color: Color.fromRGBO(211, 47, 47, 1),
                              ),
                            ),
                          ],
                        ),

                        // ---------------------------------------------------
                        // 18+ CHECKBOX
                        // ---------------------------------------------------
                        Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  side: const BorderSide(
                                      color: Colors.grey, width: 2),
                                  fillColor: WidgetStateProperty.resolveWith(
                                      (states) {
                                    if (states
                                        .contains(WidgetState.selected)) {
                                      return const Color.fromRGBO(
                                          46, 23, 21, 1);
                                    }
                                    return Colors.white;
                                  }),
                                  checkColor: WidgetStateProperty.all(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              child: Checkbox(
                                value: is18OrOlder,
                                onChanged: (value) {
                                  setState(() {
                                    is18OrOlder = value ?? false;
                                    updateButtonColor();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Text(
                                t.signup_age_checkbox,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),

                        // ---------------------------------------------------
                        // SIGNUP BUTTON
                        // ---------------------------------------------------
                        FilledButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            onSignup();
                          },
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: signupBtnColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            t.signup_button,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // LOGIN LINK
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              t.signup_have_account,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginPage(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                t.signup_login_link,
                                style: const TextStyle(
                                  color: Color.fromRGBO(0, 111, 255, 1),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // OR DIVIDER
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
                                  horizontal: 8),
                              child: Text(
                                t.common_or,
                                style:
                                    TextStyle(color: Colors.grey.shade600),
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

                        const SizedBox(height: 20),

                        // GOOGLE SIGN-IN
                        GsiMaterialButton(
                          onPressed: () async {
                            if (!mounted) return;
                            setState(() => isLoading = true);

                            final userCredential =
                                await GoogleSignInService
                                    .signInWithGoogle();

                            if (!mounted) return;
                            setState(() => isLoading = false);

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
          ),

          // LOADING OVERLAY
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
  // VALIDATORS
  // ---------------------------------------------------------------------------
  bool isUsernameValid(String username) {
    final validUsernameRegex = RegExp(r'^[a-zA-Z0-9._]+$');
    final containLetterRegex = RegExp(r'[a-zA-Z]');
    return validUsernameRegex.hasMatch(username) &&
        containLetterRegex.hasMatch(username);
  }

  void validateUsername() {
    final username = _controllerUsername.text.trim();
    final t = AppLocalizations.of(context);

    if (usernameTimer?.isActive ?? false) usernameTimer!.cancel();

    if (username.isEmpty) {
      setState(() {
        usernameWarning = '';
        usernameValid = false;
      });
      return;
    }

    if (!isUsernameValid(username)) {
      setState(() {
        usernameWarning = t.signup_username_rules;
        usernameValid = false;
      });
      return;
    }

    if (username.length < 3) {
      setState(() {
        usernameWarning = t.signup_username_min_length;
        usernameValid = false;
      });
      return;
    }

    // Debounced username check
    usernameTimer =
        Timer(const Duration(milliseconds: 500), () async {
      final existingUser = await FirebaseFirestore.instance
          .collectionGroup('public')
          .where('username', isEqualTo: username)
          .get();

      if (existingUser.docs.isNotEmpty) {
        setState(() {
          usernameWarning = t.signup_username_taken;
          usernameValid = false;
        });
      } else {
        setState(() {
          usernameWarning = '';
          usernameValid = true;
        });
      }
    });

    setState(() {
      usernameValid = true;
    });
  }

  bool isValidEmail(String email) {
    final validEmailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return validEmailRegex.hasMatch(email);
  }

  void validateEmail() {
    final email = _controllerEmail.text.trim().toLowerCase();
    final t = AppLocalizations.of(context);

    if (emailTimer?.isActive ?? false) emailTimer!.cancel();

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
    }

    setState(() {
      emailWarning = '';
      emailValid = true;
    });

    // Optional: Firestore email uniqueness check (commented)
    /*
    emailTimer = Timer(const Duration(milliseconds: 500), () async {
      final existingUser = await FirebaseFirestore.instance
          .collectionGroup('private')
          .where('email', isEqualTo: email)
          .get();

      if (existingUser.docs.isNotEmpty) {
        setState(() {
          emailWarning = t.signup_email_exists;
          emailValid = false;
        });
      } else {
        setState(() {
          emailWarning = '';
          emailValid = true;
        });
      }
    });
    */
  }

  bool isStrongPassword(String password) {
    final strongPasswordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
    return strongPasswordRegex.hasMatch(password);
  }

  void validatePassword() {
    final password = _controllerPassword.text.trim();
    final t = AppLocalizations.of(context);

    if (password.isEmpty) {
      setState(() {
        weakPasswordWarning = '';
        passwordValid = false;
      });
      return;
    }

    if (!isStrongPassword(password)) {
      setState(() {
        weakPasswordWarning = t.signup_password_weak;
        passwordValid = false;
      });
      return;
    }

    setState(() {
      weakPasswordWarning = '';
      passwordValid = true;
    });
  }

  // BUTTON COLOR LOGIC
  void updateButtonColor() {
    final filled = _controllerUsername.text.trim().isNotEmpty &&
        _controllerEmail.text.trim().isNotEmpty &&
        _controllerPassword.text.isNotEmpty &&
        is18OrOlder;

    setState(() {
      signupBtnColor =
          filled ? const Color.fromRGBO(46, 23, 21, 1) : Colors.grey.shade400;
    });
  }
}
