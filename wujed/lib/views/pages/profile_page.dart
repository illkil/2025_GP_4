import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/data/notifiers.dart';
import 'package:wujed/main.dart';
import 'package:wujed/views/pages/edit_profile_page.dart';
import 'package:wujed/views/pages/login_page.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.firstName, //not needed if the backend for edit profile is implemented
    this.lastName, //not needed if the backend for edit profile is implemented
    this.phoneNumber, //not needed if the backend for edit profile is implemented
  });

  final String? firstName;
  final String? lastName;
  final int? phoneNumber;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!; //current logged in user
  var userData;

  @override
  void initState() {
    super.initState();
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
        leading: IconButton(
          onPressed: () async {
            final result = await Navigator.push(
              //this will not be needed anymore (only the result but the navigator is needed)
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const EditProfilePage();
                },
              ),
            );

            // if (result != null) {
            //   setState(() {
            //     _firstName = (result['firstName'] ?? '').isEmpty
            //         ? null
            //         : result['firstName'];
            //     _lastName = (result['lastName'] ?? '').isEmpty
            //         ? null
            //         : result['lastName'];
            //     _phoneNumber = (result['phoneNumber'] ?? '').isEmpty
            //         ? null
            //         : result['phoneNumber'];
            //   });
            // }
          },
          icon: Icon(IconlyBold.edit, color: Colors.grey.shade600),
        ),
        title: Title(
          color: const Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            t.profile_title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    height: 230,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final currentLocale = Localizations.localeOf(
                                context,
                              ).languageCode;

                              if (currentLocale == 'ar') {
                                MyApp.of(
                                  context,
                                )!.setLocale(const Locale('en'));
                              } else {
                                MyApp.of(
                                  context,
                                )!.setLocale(const Locale('ar'));
                              }

                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.swap_horiz_rounded,
                                  color: Color.fromRGBO(46, 23, 21, 1),
                                  size: 40,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          'ar'
                                      ? t.language_en
                                      : t.language_ar,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Divider(),
                          const SizedBox(height: 20.0),
                          GestureDetector(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              setState(() {
                                selectedPageNotifier.value = 0;
                              });
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginPage();
                                  },
                                ),
                                (route) => false,
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  IconlyLight.logout,
                                  color: Color.fromRGBO(46, 23, 21, 1),
                                  size: 40,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  t.action_log_out,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                  child: const Icon(
                    IconlyBold.profile,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  userData['username'], //get user data
                  style: TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  userData['email'], //get user data
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
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
                _buildInfoBox(
                  userData['first_name'] == " "
                      ? userData['first_name']
                      : t.placeholder_not_provided, //display first name if exist, else display Not provided
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
                _buildInfoBox(
                  userData['last_name'] == " "
                      ? userData['last_name']
                      : t.placeholder_not_provided, //display last name if exist, else display Not provided
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
                _buildInfoBox(
                  userData['phone_number'] != null &&
                          userData['phone_number'].toString().trim().isNotEmpty
                      ? userData['phone_number']
                      : t.placeholder_not_provided,
                  isPhone: true, // <–– هذا الجديد
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String text, {bool isPhone = false}) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(249, 249, 249, 1),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.2), width: 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          if (isPhone) ...[
            const SizedBox(width: 15),
            const Text(
              '+966',
              style: TextStyle(
                color: Color.fromRGBO(46, 23, 21, 1),
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Text(
                text,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
