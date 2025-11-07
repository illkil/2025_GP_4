import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/views/pages/login_page.dart';

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
          isResetting = true;
        });

        final result = await FirebaseFunctions.instance
            .httpsCallable('resetUserPassword')
            .call({'email': widget.email, 'newPassword': newPassword});

        if (result.data['success'] == true) {
          setState(() {
            isResetting = false;
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
                      t.reset_password_changed_title,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                content: Text(
                  t.reset_password_changed_message,
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.end,
                actions: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                        (route) => false,
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
        } else {
          setState(() {
            errorText = t.reset_password_failed;
            isResetting = false;
          });
        }
      } else {
        throw Exception('');
      }
    } catch (e) {
      setState(() {
        errorText = t.reset_password_error;
        isResetting = false;
      });
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controllerNewPassword.dispose();
  //   _controllerNewPassword.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

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
                      t.reset_title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),

                    const SizedBox(height: 10.0),

                    Text(
                      t.reset_subtitle,
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
                        labelText: t.reset_new_password_label,
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
                        labelText: t.reset_confirm_password_label,
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
                        FocusScope.of(context).unfocus();
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
                        t.reset_button,
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
        confirmPasswordWarning = t.reset_password_match;
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
        confirmPasswordWarning = t.reset_password_match;
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
