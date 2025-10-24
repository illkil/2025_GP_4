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

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    super.initState();
    _controllerUsername.addListener(updateButtonColor);
    _controllerEmail.addListener(updateButtonColor);
    _controllerPassword.addListener(
      updateButtonColor,
    ); //add listener for immediate error checking
    _controllerUsername.addListener(validateUsername);
    _controllerEmail.addListener(validateEmail);
    _controllerPassword.addListener(validatePassword);
  }

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String text = '';
  String usernameWarning = "";
  String emailWarning = "";
  String weakPasswordWarning = "";
  Color textColor = Colors.grey.shade600;
  Color signupBtnColor = Colors.grey.shade400;

  bool hidePassword = true;
  bool is18OrOlder = false;
  bool isLoading = false;
  bool usernameValid = false;
  bool emailValid = false;
  bool passwordValid = false;

  Timer? usernameTimer;
  Timer? emailTimer;

  Future onSignup() async {
    final t = AppLocalizations.of(context);

    //set these as empty at the start of the method so error messages dont stay on screen all the time when there is no longer an error
    setState(() {
      text = t.signup_subtitle;
      textColor = Colors.grey.shade600;
    });

    final username = _controllerUsername.text
        .trim(); //controllers connected to its designated textfields
    final email = _controllerEmail.text.trim().toLowerCase();
    final password = _controllerPassword.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      //check if any of the fields are empty first
      setState(() {
        text = t.login_error_fill_all;
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }

    if (is18OrOlder == false) {
      //check if the user has checked the 18 years or older checkboc before continuing
      setState(() {
        text = t.check_18yo_checkbox;
        textColor = const Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }

    try {
      if (usernameValid && emailValid && passwordValid) {
        setState(() {
          isLoading = true; // start loading
        });

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        //assigned the user creation to user credintials so we can access the user id and store the username and other user data in a collection

        final user = userCredential.user!;

        final prefs = await SharedPreferences.getInstance();
        final String? lang = prefs.getString('preferredLanguage');

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          //create the user collection (storing the user in firestore)
          'user_id': user.uid,
          'username': username,
          'email': email,
          'profile_photo': '',
          'first_name': '',
          'last_name': '',
          'phone_number': '',
          'role':
              'user', //this might be a security concern, stating the user role in client side is wrong its better to do it in server side somehow, i'll check it later
          'language': lang ?? 'en',
          'created_at': Timestamp.now(),
        });

        await user.updateDisplayName(
          username,
        ); //setting the display name that firebase associates with the user to username

        await user.sendEmailVerification();

        setState(() {
          isLoading = false; // stop loading before showing dialog
        });

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
                    t.signup_account_created_success,
                    style: const TextStyle(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                      ), //go to log in after creating an account successfully
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

  @override
  void dispose() {
    //not used anymore, dispose
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    usernameTimer?.cancel();
    emailTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    text = text.isEmpty ? t.signup_subtitle : text;

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

                      TextField(
                        controller: _controllerUsername,
                        autocorrect: false,
                        maxLength: 20,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: t.signup_username_label,
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
                            usernameWarning,
                            style: const TextStyle(
                              color: Color.fromRGBO(211, 47, 47, 1),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20.0),

                      TextField(
                        controller: _controllerEmail,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: t.signup_email_label,
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
                          labelText: t.signup_password_label,
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
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            weakPasswordWarning,
                            style: const TextStyle(
                              color: Color.fromRGBO(211, 47, 47, 1),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                side: const BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return const Color.fromRGBO(
                                          46,
                                          23,
                                          21,
                                          1,
                                        );
                                      }
                                      return Colors.white;
                                    }),
                                checkColor: WidgetStateProperty.all<Color>(
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
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),

                      FilledButton(
                        onPressed: () {
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
                            t.signup_have_account,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginPage();
                                  },
                                ),
                                (route) => false,
                              );
                            },
                            child: Text(
                              t.signup_login_link,
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
                          final userCredential =
                              await GoogleSignInService.signInWithGoogle();
                          if (userCredential != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ),
                            );
                          }
                        },
                        text: t.google_signup,
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

  bool isUsernameValid(String username) {
    //user name can contain only letters and numbers and . and _
    final validUsernameRegex = RegExp(r'^[a-zA-Z0-9._]+$');
    final containLetterRegex = RegExp(r'[a-zA-Z]');
    return validUsernameRegex.hasMatch(username) && containLetterRegex.hasMatch(username);
  }

  void validateUsername() {
    //immediate error checking
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

    usernameTimer = Timer(const Duration(milliseconds: 500), () async {
      final existingUser = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get(); //check if the username is taking or not if there is a username same as what the user entered assign it to existingUser

      if (existingUser.docs.isNotEmpty) {
        //username is taking (existingUser is not empty)
        setState(() {
          usernameWarning = t.signup_username_taken;
          usernameValid = false;
        });
        return;
      } else {
        setState(() {
          usernameWarning = '';
          usernameValid = true;
        });
        return;
      }
    });

    setState(() {
      usernameValid = true;
    });
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

    emailTimer = Timer(const Duration(milliseconds: 500), () async {
      final existingUser = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get(); //check if the email is taking or not if there is a email same as what the user entered assign it to existingUser

      if (existingUser.docs.isNotEmpty) {
        //email is taking (existingUser is not empty)
        setState(() {
          emailWarning = t.signup_email_exists;
          emailValid = false;
        });
        return;
      } else {
        setState(() {
          emailWarning = '';
          emailValid = true;
        });
        return;
      }
    });

    setState(() {
      emailValid = true;
    });
  }

  bool isStrongPassword(String password) {
    //immediate error checking
    //password must be 8+ characters, include upper/lowercase, and numbers
    final strongPasswordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$',
    );
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
    } else {
      setState(() {
        weakPasswordWarning = '';
        passwordValid = true;
      });
    }

    setState(() {
      passwordValid = true;
    });
  }

  void updateButtonColor() {
    final filled =
        _controllerUsername.text.trim().isNotEmpty &&
        _controllerEmail.text.trim().isNotEmpty &&
        _controllerPassword.text.isNotEmpty &&
        is18OrOlder;

    setState(() {
      signupBtnColor = filled
          ? const Color.fromRGBO(46, 23, 21, 1)
          : Colors.grey.shade400;
    });
  }
}
