import 'dart:async';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/views/pages/login_page.dart';

class VerifyPage extends StatefulWidget {
  final String email;
  const VerifyPage({super.key, required this.email});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  TextEditingController field1Controller = TextEditingController();
  TextEditingController field2Controller = TextEditingController();
  TextEditingController field3Controller = TextEditingController();
  TextEditingController field4Controller = TextEditingController();

  String errorText = '';
  bool isVerifying = false;
  bool isSendingEmail = false;
  bool canResend = false;
  int remainingSeconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  void startResendTimer() {
    setState(() {
      canResend = false;
      remainingSeconds = 30;
    });
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          canResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future verifyingOTPCode(String code) async {
    final t = AppLocalizations.of(context);

    setState(() {
      isVerifying = true;
      errorText = '';
    });

    bool verified = await EmailOTP.verifyOTP(otp: code);

    setState(() {
      isVerifying = false;
    });

    if (verified) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return ResetPasswordPage(email: widget.email);
      //     },
      //   ),
      // );
      if (!mounted) return;

      setState(() {
        isSendingEmail = true;
      });

      await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.email);

      setState(() {
        isSendingEmail = false;
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
                  t.verify_reset_password_email,
                  style: const TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
              t.verify_reset_password_info,
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
        errorText = t.verify_invalid_code;
      });
    }
  }

  Future resendOTP() async {
    final t = AppLocalizations.of(context);

    setState(() {
      errorText = '';
    });

    EmailOTP.config(appName: "Wujed", otpLength: 4, otpType: OTPType.numeric);

    bool sent = await EmailOTP.sendOTP(email: widget.email);

    if (sent) {
      setState(() {
        errorText = t.verify_new_otp_sent;
      });
      startResendTimer();
    } else {
      setState(() {
        errorText = t.verify_failed_resend_otp;
      });
    }
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
                      t.verify_title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),

                    const SizedBox(height: 10.0),

                    Text(
                      t.verify_subtitle,
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

                    const SizedBox(height: 40.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        otpFields(context, field1Controller),
                        SizedBox(width: 10.0),
                        otpFields(context, field2Controller),
                        SizedBox(width: 10.0),
                        otpFields(context, field3Controller),
                        SizedBox(width: 10.0),
                        otpFields(context, field4Controller),
                      ],
                    ),

                    const SizedBox(height: 20.0),

                    FilledButton(
                      onPressed: () {
                        final code =
                            field1Controller.text.trim() +
                            field2Controller.text.trim() +
                            field3Controller.text.trim() +
                            field4Controller.text.trim();

                        if (code.length < 4) {
                          setState(() {
                            errorText = t.login_error_fill_all;
                          });
                          return;
                        }

                        verifyingOTPCode(code);
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color.fromRGBO(46, 23, 21, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        t.verify_button,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            canResend
                                ? resendOTP()
                                : setState(() {
                                    errorText = t.verify_wait_timer;
                                  });
                          },
                          child: Text(
                            t.verify_resend,
                            style: TextStyle(
                              color: canResend
                                  ? Color.fromRGBO(0, 111, 255, 1)
                                  : Colors.grey.shade600,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1,
                              decorationColor: canResend
                                  ? Color.fromRGBO(0, 111, 255, 1)
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                        Text(
                          canResend
                              ? '0:00'
                              : '0:${remainingSeconds.toString().padLeft(2, '0')}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isVerifying ||
              isSendingEmail) //wait for user account to be created
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

  Widget otpFields(BuildContext context, TextEditingController controller) {
    return SizedBox(
      height: 60,
      width: 60,
      child: TextField(
        controller: controller,
        autocorrect: false,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color.fromRGBO(46, 23, 21, 1),
              width: 2.0,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          FocusScope.of(context).nextFocus();
        },
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
