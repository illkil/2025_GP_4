import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        surfaceTintColor: Colors.transparent,
        title: Title(
          color: Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              onDonePressed();
            },
            child: Text(
              'Done',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade500,
                ),
                child: Icon(IconlyBold.profile, color: Colors.white, size: 70),
              ),
              SizedBox(height: 10.0),
              Text(
                'Change Profile Picture',
                style: TextStyle(
                  color: Color.fromRGBO(46, 23, 21, 1),
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 20.0),

              Row(
                children: [
                  Text(
                    'First Name',
                    style: TextStyle(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),

              SizedBox(
                height: 50,
                width: double.infinity,

                child: TextField(
                  controller: controllerFirstName,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Not provided',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
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
                    suffixIcon: Icon(
                      IconlyBold.edit,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0),

              Row(
                children: [
                  Text(
                    'Last Name',
                    style: TextStyle(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),

              SizedBox(
                height: 50,
                width: double.infinity,

                child: TextField(
                  controller: controllerLastName,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Not provided',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
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
                    suffixIcon: Icon(
                      IconlyBold.edit,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),

              SizedBox(
                height: 50,
                width: double.infinity,

                child: TextField(
                  controller: controllerPhoneNumber,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'Not provided',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
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
                    suffixIcon: Icon(
                      IconlyBold.edit,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onDonePressed() {
    final firstName = controllerFirstName.text.trim();
    final lastName = controllerLastName.text.trim();
    final phoneNumber = controllerPhoneNumber.text.trim();

    Navigator.pop(context, {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    });
  }
}
