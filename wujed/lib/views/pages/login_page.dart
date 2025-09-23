import 'package:flutter/material.dart';
import 'package:wujed/views/pages/forgot_password_page.dart';
import 'package:wujed/views/pages/signup_page.dart';
import 'package:wujed/views/widget_tree.dart';
import 'package:wujed/widgets/google_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    controllerEmail.addListener(updateButtonColor);
    controllerPassword.addListener(updateButtonColor);
  }

  TextEditingController controllerEmail = TextEditingController(text: '123');
  TextEditingController controllerPassword = TextEditingController(text: '456');
  String confirmedEmail = '123';
  String confirmedPassword = '456';

  String text = 'Please Log in to continue';
  Color textColor = Colors.grey.shade600;
  Color loginBtnColor = Colors.grey.shade400;

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                  color: Color.fromRGBO(46, 23, 21, 1),
                ),
              ),

              SizedBox(height: 10.0),

              Text(text, style: TextStyle(fontSize: 16.0, color: textColor)),

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

              TextField(
                controller: controllerPassword,
                obscureText: hidePassword,
                obscuringCharacter: '*',
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
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
                  setState(() {});
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ForgotPasswordPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
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

              SizedBox(height: 30.0),

              FilledButton(
                onPressed: () {
                  onLoginPressed();
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: loginBtnColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignupPage();
                          },
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 111, 255, 1),
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                        decorationColor: Color.fromRGBO(0, 111, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.0),

              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.shade400, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey.shade400, thickness: 1),
                  ),
                ],
              ),

              SizedBox(height: 20.0),

              GsiMaterialButton(onPressed: () {}, text: 'Continue with Google'),
            ],
          ),
        ),
      ),
    );
  }

  void updateButtonColor() {
    final filled =
        controllerEmail.text.trim().isNotEmpty &&
        controllerPassword.text.isNotEmpty;

    setState(() {
      loginBtnColor = filled
          ? Color.fromRGBO(46, 23, 21, 1) // active color
          : Colors.grey.shade400; // inactive color
    });
  }

  void onLoginPressed() {
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        text = "Please fill all the details";
        textColor = Color.fromRGBO(211, 47, 47, 1);
      });
    } else {
      if (email == confirmedEmail && password == confirmedPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return WidgetTree();
            },
          ),
        );
      } else {
        setState(() {
          text = "Invalid email or password";
          textColor = Color.fromRGBO(211, 47, 47, 1);
        });
      }
    }
  }
}
