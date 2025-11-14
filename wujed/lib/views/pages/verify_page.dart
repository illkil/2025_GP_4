import 'dart:async';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/views/pages/reset_password_page.dart';

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

  Color verifyBtnColor = Colors.grey.shade400;
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ResetPasswordPage(email: widget.email);
          },
        ),
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
                        FocusScope.of(context).unfocus();
                        final isArabic =
                            Localizations.localeOf(context).languageCode ==
                            'ar';

                        final f1 = field1Controller.text.trim();
                        final f2 = field2Controller.text.trim();
                        final f3 = field3Controller.text.trim();
                        final f4 = field4Controller.text.trim();

                        final code = isArabic
                            ? "$f4$f3$f2$f1" //reverse order for Arabic
                            : "$f1$f2$f3$f4"; //normal order for English

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
                        backgroundColor: verifyBtnColor,
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
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(
          controller: controller,
          autocorrect: false,
          maxLength: 1,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            if (value.isNotEmpty) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).previousFocus();
            }
            updateButtonColor();
          },
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }

  void updateButtonColor() {
    final filled =
        field1Controller.text.trim().isNotEmpty &&
        field2Controller.text.trim().isNotEmpty &&
        field3Controller.text.trim().isNotEmpty &&
        field4Controller.text.trim().isNotEmpty;

    setState(() {
      verifyBtnColor = filled
          ? const Color.fromRGBO(46, 23, 21, 1)
          : Colors.grey.shade400;
    });
  }
}
