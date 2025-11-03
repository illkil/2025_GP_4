import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = FirebaseAuth.instance.currentUser!; //current logged in user
  var userData;

  final TextEditingController _controllerUsername = TextEditingController();
  // TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();

  bool updateMade = false;
  String usernameWarning = "";
  bool usernameValid = false;
  String firstNameWarning = "";
  bool firstNameValid = false;
  String lastNameWarning = "";
  bool lastNameValid = false;
  String phoneNumberWarning = "";
  bool phoneNumberValid = false;
  Timer? usernameTimer;

  @override
  void initState() {
    super.initState();
    _controllerUsername.addListener(validateUsername);
    _controllerFirstName.addListener(validateFirstName);
    _controllerLastName.addListener(validateLastName);
    _controllerPhoneNumber.addListener(validatePhoneNumber);
    _loadUserData();
  }

  Future _loadUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get(); //get the doc associated with the uses
      if (doc.exists) {
        setState(() {
          userData = doc.data(); //if it exist set userdata to the doc data
          _controllerUsername.text = userData['username'] ?? '';
          _controllerFirstName.text = userData['first_name'] ?? '';
          _controllerLastName.text = userData['last_name'] ?? '';
          _controllerPhoneNumber.text = userData['phone_number'] ?? '';
        });
      }
    } catch (e) {
      print(
        'Error loading user data: $e',
      ); //incase any error happens while loading
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      //wait for user data to load before showing the page
      return const Scaffold(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        body: Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(255, 175, 0, 1),
          ),
        ),
      );
    }

    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        surfaceTintColor: Colors.transparent,
        title: Title(
          color: const Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            t.edit_profile_title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),

        actions: [
          TextButton(
            onPressed: () {
              onDonePressed();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                t.action_done,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                  child: const Icon(
                    IconlyBold.profile,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  t.edit_profile_change_picture,
                  style: const TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20.0),

                Row(
                  children: [
                    Text(
                      t.signup_username_label,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                _buildTextField(
                  _controllerUsername,
                  TextInputType.text,
                  [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9._]'))],
                  hint: userData['username'],
                ),
                if (usernameWarning != '')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        usernameWarning,
                        style: const TextStyle(
                          color: Color.fromRGBO(211, 47, 47, 1),
                        ),
                      ),
                    ],
                  ),

                // const SizedBox(height: 20.0),

                // Row(
                //   children: [
                //     Text(
                //       t.signup_email_label,
                //       style: const TextStyle(
                //         color: Color.fromRGBO(46, 23, 21, 1),
                //         fontSize: 18,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 10.0),
                // _buildTextField(_controllerEmail, TextInputType.text, [
                //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                // ], hint: userData['email']),
                const SizedBox(height: 20.0),

                Row(
                  children: [
                    Text(
                      t.label_first_name,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                _buildTextField(
                  _controllerFirstName,
                  TextInputType.text,
                  [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                  hint: userData['first_name'] == ''
                      ? t.placeholder_not_provided
                      : userData['first_name'],
                ),
                if (firstNameWarning != '')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        firstNameWarning,
                        style: const TextStyle(
                          color: Color.fromRGBO(211, 47, 47, 1),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 20.0),

                Row(
                  children: [
                    Text(
                      t.label_last_name,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                _buildTextField(
                  _controllerLastName,
                  TextInputType.text,
                  [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                  hint: userData['last_name'] == ''
                      ? t.placeholder_not_provided
                      : userData['last_name'],
                ),
                if (lastNameWarning != '')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        lastNameWarning,
                        style: const TextStyle(
                          color: Color.fromRGBO(211, 47, 47, 1),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 20.0),

                Row(
                  children: [
                    Text(
                      t.label_phone_number,
                      style: const TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                _buildTextField(
                  _controllerPhoneNumber,
                  TextInputType.phone,
                  [FilteringTextInputFormatter.digitsOnly],
                  hint: userData['phone_number'] == ''
                      ? t.phone_placeholder
                      : userData['phone_number'],
                  isPhone: true,
                ),
                if (phoneNumberWarning != '')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        phoneNumberWarning,
                        style: const TextStyle(
                          color: Color.fromRGBO(211, 47, 47, 1),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    TextInputType type,
    List<TextInputFormatter> formatters, {
    required String hint,
    bool isPhone = false,
  }) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        controller: controller,
        keyboardType: type,
        inputFormatters: formatters,
        maxLength: isPhone ? 9 : 20,
        autocorrect: false,
        decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color.fromRGBO(46, 23, 21, 1),
              width: 2.0,
            ),
          ),
          suffixIcon: Icon(IconlyBold.edit, color: Colors.grey.shade400),
          prefixIcon: isPhone
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 15,
                        top: 3,
                      ),
                      child: Text(
                        '+966',
                        style: const TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 10,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
                )
              : null,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 60,
            minHeight: 0,
          ),
        ),
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Future onDonePressed() async {
    final username = _controllerUsername.text.trim();
    final firstName = _controllerFirstName.text.trim();
    final lastName = _controllerLastName.text.trim();
    final phoneNumber = _controllerPhoneNumber.text.trim();
    final t = AppLocalizations.of(context);

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return; // User is not logged in

    try {
      final firestore = await FirebaseFirestore.instance;

      if (username == userData['username'].toString().trim() &&
          firstName == userData['first_name'].toString().trim() &&
          lastName == userData['last_name'].toString().trim() &&
          phoneNumber == userData['phone_number'].toString().trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.warning_rounded, color: Color.fromRGBO(46, 23, 21, 1)),
                const SizedBox(width: 10),
                Text(
                  t.no_new_data_entered,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFFFE4B3),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 10,
          ),
        );
        return;
      }

      if (username.isNotEmpty &&
          usernameValid &&
          username != userData['username'].toString().trim()) {
        await firestore.collection('users').doc(user.uid).update({
          'username': username,
        });
        updateMade = true;
      }
      if (firstName.isNotEmpty &&
          firstNameValid &&
          firstName != userData['first_name'].toString().trim()) {
        await firestore.collection('users').doc(user.uid).update({
          'first_name': firstName,
        });
        updateMade = true;
      }
      if (lastName.isNotEmpty &&
          lastNameValid &&
          lastName != userData['last_name'].toString().trim()) {
        await firestore.collection('users').doc(user.uid).update({
          'last_name': lastName,
        });
        updateMade = true;
      }
      if (phoneNumber.isNotEmpty &&
          phoneNumberValid &&
          phoneNumber != userData['phone_number'].toString().trim()) {
        await firestore.collection('users').doc(user.uid).update({
          'phone_number': phoneNumber,
        });
        updateMade = true;
      }
      if (updateMade) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Color.fromRGBO(46, 23, 21, 1)),
                const SizedBox(width: 10),
                Text(
                  t.profile_update_success,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFFFE4B3),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 10,
          ),
        );

        Navigator.pop(context, true); //go back to profile page
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning_rounded, color: Color.fromRGBO(46, 23, 21, 1),),
              const SizedBox(width: 10),
              Text(
                t.profile_update_failed,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(46, 23, 21, 1),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFFFE4B3),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10,
        ),
      );
    }
  }

  bool isUsernameValid(String username) {
    //user name can contain only letters and numbers and . and _
    final validUsernameRegex = RegExp(r'^[a-zA-Z0-9._]+$');
    final containLetterRegex = RegExp(r'[a-zA-Z]');
    return validUsernameRegex.hasMatch(username) &&
        containLetterRegex.hasMatch(username);
  }

  void validateUsername() {
    //immediate error checking
    final username = _controllerUsername.text.trim();
    final t = AppLocalizations.of(context);

    if (usernameTimer?.isActive ?? false) usernameTimer!.cancel();

    if (username.isEmpty) {
      setState(() {
        usernameWarning = '';
        usernameValid = false;
      });
      return;
    }

    if (!isUsernameValid(username)) {
      setState(() {
        usernameWarning = t.signup_username_rules;
        usernameValid = false;
      });
      return;
    }

    if (username.length < 3) {
      setState(() {
        usernameWarning = t.signup_username_min_length;
        usernameValid = false;
      });
      return;
    }

    usernameTimer = Timer(const Duration(milliseconds: 500), () async {
      final existingUser = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get(); //check if the username is taking or not if there is a username same as what the user entered assign it to existingUser

      if (existingUser.docs.isNotEmpty &&
          existingUser.docs.first.id != user.uid) {
        //username is taken and it does not belong to current user
        setState(() {
          usernameWarning = t.signup_username_taken;
          usernameValid = false;
        });
      } else {
        setState(() {
          usernameWarning = '';
          usernameValid = true;
        });
        return;
      }
    });

    setState(() {
      usernameValid = true;
    });
  }

  void validateFirstName() {
    final firstName = _controllerFirstName.text.trim();
    final t = AppLocalizations.of(context);

    if (firstName.length < 2) {
      setState(() {
        firstNameWarning = t.first_name_too_short;
        firstNameValid = false;
      });
      return;
    } else {
      setState(() {
        firstNameWarning = '';
        firstNameValid = true;
      });
    }

    firstNameValid = true;
  }

  void validateLastName() {
    final lastName = _controllerLastName.text.trim();
    final t = AppLocalizations.of(context);

    if (lastName.length < 2) {
      setState(() {
        lastNameWarning = t.last_name_too_short;
        lastNameValid = false;
      });
      return;
    } else {
      setState(() {
        lastNameWarning = '';
        lastNameValid = true;
      });
    }

    lastNameValid = true;
  }

  void validatePhoneNumber() {
    final phoneNumber = _controllerPhoneNumber.text.trim();
    final t = AppLocalizations.of(context);

    if (phoneNumber.length != 9) {
      setState(() {
        phoneNumberWarning = t.phone_invalid_length;
        phoneNumberValid = false;
      });
      return;
    }
    setState(() {
      phoneNumberWarning = '';
      phoneNumberValid = true;
    });

    phoneNumberValid = true;
  }
}
