import 'package:flutter/material.dart';
import 'package:wujed/views/pages/login_page.dart';
import 'package:wujed/widgets/google_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    super.initState();
    controllerEmail.addListener(updateButtonColor);
    controllerPassword.addListener(updateButtonColor);
  }

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String takenUsername = '111';
  String existedEmail = '123';

  String text = 'Fill all the details to create your account';
  String takenUsernameWarning = "";
  String existingEmailWarning = "";
  String weakPasswordWarning = "";
  Color textColor = Colors.grey.shade600;
  Color signupBtnColor = Colors.grey.shade400;

  bool hidePassword = true;
  bool is18OrOlder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Join Us!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
                ),
                  
                SizedBox(height: 10.0),
                  
                Text(text, style: TextStyle(fontSize: 16.0, color: textColor)),
                  
                SizedBox(height: 50.0),
                  
                TextField(
                  controller: controllerUsername,
                  decoration: InputDecoration(
                    labelText: 'Username',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      takenUsernameWarning,
                      style: TextStyle(color: Color.fromRGBO(211, 47, 47, 1)),
                    ),
                  ],
                ),
                  
                SizedBox(height: 10.0),
                  
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      existingEmailWarning,
                      style: TextStyle(color: Color.fromRGBO(211, 47, 47, 1)),
                    ),
                  ],
                ),
                  
                SizedBox(height: 10.0),
                  
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      weakPasswordWarning,
                      style: TextStyle(color: Color.fromRGBO(211, 47, 47, 1)),
                    ),
                  ],
                ),
                  
                Image.asset('lib/assets/images/reCAPTCHA.png', width: 400),
                  
                SizedBox(height: 5.0),
                  
                Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        checkboxTheme: CheckboxThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: const BorderSide(color: Colors.grey, width: 2),
                          fillColor: WidgetStateProperty.resolveWith<Color>((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color.fromRGBO(46, 23, 21, 1);
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
                    const Expanded(
                      child: Text(
                        "I am 18 years old or older",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                  
                FilledButton(
                  onPressed: () {
                    onLoginPressed();
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: signupBtnColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                  
                SizedBox(height: 10.0),
                  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    TextButton(
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
                      child: Text(
                        'Log In',
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
                  
                GsiMaterialButton(onPressed: () {}, text: 'Sign up with Google'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateButtonColor() {
    final filled =
        controllerUsername.text.trim().isNotEmpty &&
        controllerEmail.text.trim().isNotEmpty &&
        controllerPassword.text.isNotEmpty &&
        is18OrOlder;

    setState(() {
      signupBtnColor = filled
          ? Color.fromRGBO(46, 23, 21, 1)
          : Colors.grey.shade400;
    });
  }

  void onLoginPressed() {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        text = 'Please fill all the details';
        textColor = Color.fromRGBO(211, 47, 47, 1);
      });
      return;
    }
    if (username == takenUsername ||
        email == existedEmail ||
        password.length < 8) {
      if (username == takenUsername) {
        setState(() {
          takenUsernameWarning = 'This username is taken';
        });
      } else {
        setState(() {
          takenUsernameWarning = '';
        });
      }
      if (email == existedEmail) {
        setState(() {
          existingEmailWarning = 'This email already exists';
        });
      } else {
        setState(() {
          existingEmailWarning = '';
        });
      }
      if (password.length < 8) {
        setState(() {
          weakPasswordWarning =
              'Use 8 or more characters with a mix of\nuppercase and lowercase letters and\nnumbers';
        });
      } else {
        setState(() {
          weakPasswordWarning = '';
        });
      }
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
        (route) => false,
      );
    }
  }
}
