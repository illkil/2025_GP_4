import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _controllerNewPassword = TextEditingController();
  TextEditingController _controllerConfirmPassword = TextEditingController();

  Color resetPasswordBtnColor = Colors.grey.shade400;
  String errorText = '';
  bool isResetting = false;
  String newPasswordWarning = '';
  String confirmPasswordWarning = '';
  bool newPasswordValid = false;
  bool confirmPasswordValid = false;
  bool hideNewPassword = true;
  bool hideConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _controllerNewPassword.addListener(updateButtonColor);
    _controllerConfirmPassword.addListener(updateButtonColor);
    _controllerNewPassword.addListener(validateNewPassword);
    _controllerConfirmPassword.addListener(validateConfirmPassword);
  }

  Future resetPassword() async {
    final newPassword = _controllerNewPassword.text.trim();
    final confirmPassword = _controllerConfirmPassword.text.trim();
    final t = AppLocalizations.of(context);

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        errorText = t.login_error_fill_all;
      });
      return;
    }

    try {
      if (newPasswordValid && confirmPasswordValid) {
        setState(() {
          errorText = '';
        });

        final user = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: widget.email)
            .get();

            
      } else {
        throw FirebaseAuthException(code: '');
      }
    } on FirebaseAuthException catch (e) {}
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controllerNewPassword.dispose();
  //   _controllerNewPassword.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60.0),

                    Text(
                      'Reset Password',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),

                    const SizedBox(height: 10.0),

                    Text(
                      'Enter and confirm your new password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 10.0),

                    if (errorText.isNotEmpty)
                      Text(
                        errorText,
                        style: TextStyle(
                          color: Color.fromRGBO(211, 47, 47, 1),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),

                    const SizedBox(height: 30.0),

                    TextField(
                      controller: _controllerNewPassword,
                      autocorrect: false,
                      obscureText: hideNewPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'New Password',
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
                              hideNewPassword = !hideNewPassword;
                            });
                          },
                          icon: Icon(
                            hideNewPassword
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
                          newPasswordWarning,
                          style: const TextStyle(
                            color: Color.fromRGBO(211, 47, 47, 1),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20.0),

                    TextField(
                      controller: _controllerConfirmPassword,
                      autocorrect: false,
                      obscureText: hideConfirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                              hideConfirmPassword = !hideConfirmPassword;
                            });
                          },
                          icon: Icon(
                            hideConfirmPassword
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
                          confirmPasswordWarning,
                          style: const TextStyle(
                            color: Color.fromRGBO(211, 47, 47, 1),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30.0),

                    FilledButton(
                      onPressed: () {
                        resetPassword();
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: resetPasswordBtnColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        "Reset Password",
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
          ),
          if (isResetting) //wait for user account to change password
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

  bool isStrongPassword(String password) {
    //immediate error checking
    //password must be 8+ characters, include upper/lowercase, and numbers
    final strongPasswordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$',
    );
    return strongPasswordRegex.hasMatch(password);
  }

  void validateNewPassword() {
    final newPassword = _controllerNewPassword.text.trim();
    final confirmPassword = _controllerConfirmPassword.text.trim();
    final t = AppLocalizations.of(context);

    if (newPassword.isEmpty) {
      setState(() {
        newPasswordWarning = '';
        newPasswordValid = false;
      });
      return;
    }

    if (!isStrongPassword(newPassword)) {
      setState(() {
        newPasswordWarning = t.signup_password_weak;
        newPasswordValid = false;
      });
      return;
    } else {
      setState(() {
        newPasswordWarning = '';
        newPasswordValid = true;
      });
    }

    if (confirmPassword != newPassword && confirmPassword.isNotEmpty) {
      setState(() {
        confirmPasswordWarning = 'Passwords must match';
        confirmPasswordValid = false;
      });
      return;
    } else {
      setState(() {
        confirmPasswordWarning = '';
        confirmPasswordValid = true;
        newPasswordValid = true;
      });
    }

    setState(() {
      newPasswordValid = true;
    });
  }

  void validateConfirmPassword() {
    final newPassword = _controllerNewPassword.text.trim();
    final confirmPassword = _controllerConfirmPassword.text.trim();
    final t = AppLocalizations.of(context);

    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPasswordWarning = '';
        confirmPasswordValid = false;
      });
      return;
    }

    if (confirmPassword != newPassword) {
      setState(() {
        confirmPasswordWarning = 'Passwords must match';
        confirmPasswordValid = false;
      });
      return;
    } else {
      setState(() {
        confirmPasswordWarning = '';
        confirmPasswordValid = true;
      });
    }

    setState(() {
      confirmPasswordValid = true;
    });
  }

  void updateButtonColor() {
    final filled =
        _controllerNewPassword.text.trim().isNotEmpty &&
        _controllerConfirmPassword.text.trim().isNotEmpty;

    setState(() {
      resetPasswordBtnColor = filled
          ? const Color.fromRGBO(46, 23, 21, 1)
          : Colors.grey.shade400;
    });
  }
}
