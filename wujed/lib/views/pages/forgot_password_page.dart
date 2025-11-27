import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wujed/views/pages/verify_page.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:email_otp/email_otp.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    super.initState();
    _controllerEmail.addListener(updateButtonColor);
    _controllerEmail.addListener(
      validateEmail,
    ); //add listener for immediate error checking
  }

  TextEditingController _controllerEmail = TextEditingController();
  Color sendOTPBtnColor = Colors.grey.shade400;
  String errorText = '';
  Color textColor = Colors.grey.shade600;
  bool isSending = false;
  bool isEmailValid = false;

  String generateOTP() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString(); //4-digit OTP
  }

  Future passwordReset() async {
    final t = AppLocalizations.of(context);

    //set these as empty at the start of the method so error messages dont stay on screen all the time when there is no longer an error
    if (isEmailValid) {
      setState(() {
        errorText = '';
        textColor = Colors.grey.shade600;
      });
    }

    final email = _controllerEmail.text.trim().toLowerCase();

    if (email.isEmpty) {
      setState(() {
        textColor = Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }
    if (isEmailValid) {
      try {
        setState(() {
          isSending = true;
        });

        //Configure EmailOTP (thats gonna be sent to user)
        EmailOTP.config(
          appName: "Wujed",
          otpLength: 4,
          otpType: OTPType.numeric,
        );

        //Send the OTP sent will be true or false,
        final sent = await EmailOTP.sendOTP(email: email);

        setState(() {
          isSending = false;
        });

        if (!sent) {
          setState(() {
            errorText = t.forgot_failed_otp;
          });
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyPage(email: email)),
        );
      } catch (e) {
        setState(() {
          errorText = t.forgot_network_error;
        });
        return;
      }
    }
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

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
                      style: TextStyle(fontSize: 16.0, color: textColor),
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

                    const SizedBox(height: 40.0),

                    TextField(
                      autocorrect: false,
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9@._\-]'),
                        ),
                      ],
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
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                    ),

                    const SizedBox(height: 20.0),

                    FilledButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        passwordReset();
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: sendOTPBtnColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        t.forgot_send_otp_code,
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
          if (isSending) //wait for user account to be created
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
        errorText = '';
        textColor = Colors.grey.shade600;
        isEmailValid = false;
      });
      return;
    } else {
      setState(() {
        textColor = Colors.grey.shade600;
        isEmailValid = true;
      });
    }

    if (!isValidEmail(email)) {
      setState(() {
        errorText = t.signup_invalid_email_format;
        isEmailValid = false;
      });
      return;
    } else {
      setState(() {
        errorText = '';
        isEmailValid = true;
      });
      return;
    }
  }

  void updateButtonColor() {
    final filled = _controllerEmail.text.trim().isNotEmpty;

    setState(() {
      sendOTPBtnColor = filled
          ? const Color.fromRGBO(46, 23, 21, 1)
          : Colors.grey.shade400;
    });
  }
}
