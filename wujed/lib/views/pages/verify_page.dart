import 'package:flutter/material.dart';
import 'package:wujed/views/pages/login_page.dart';
import 'package:wujed/widgets/otp_fields.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 60.0),

              Text(
                'OTP Verification',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
              ),

              SizedBox(height: 10.0),

              Text(
                'Please check you email for the\nverification code',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
              ),

              SizedBox(height: 50.0),

              OtpFields(onCompleted: (code) {}),

              SizedBox(height: 20.0),

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
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Verify',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend code',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 111, 255, 1),
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                        decorationColor: Color.fromRGBO(0, 111, 255, 1),
                      ),
                    ),
                  ),
                  Text('0:00'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
