import 'package:flutter/material.dart';
import 'package:wujed/views/pages/verify_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    super.initState();
    controllerEmail.addListener(updateButtonColor);
  }

  TextEditingController controllerEmail = TextEditingController();
  String confirmedEmail = '123';

  Color resetPasswordBtnColor = Colors.grey.shade400;

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
                'Forgot Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
              ),

              SizedBox(height: 10.0),

              Text(
                'Enter your email account to\nreset your password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
              ),

              SizedBox(height: 50.0),

              TextField(
                controller: controllerEmail,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 16.0),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  floatingLabelStyle: TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      width: 2.0,
                    ),
                  ),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
              ),

              SizedBox(height: 30.0),

              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VerifyPage();
                      },
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: resetPasswordBtnColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateButtonColor() {
    final filled = controllerEmail.text.trim().isNotEmpty;

    setState(() {
      resetPasswordBtnColor = filled
          ? Color.fromRGBO(46, 23, 21, 1)
          : Colors.grey.shade400;
    });
  }
}
