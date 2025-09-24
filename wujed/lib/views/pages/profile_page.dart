import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wujed/data/notifiers.dart';
import 'package:wujed/views/pages/edit_profile_page.dart';
import 'package:wujed/views/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  final String? firstName;
  final String? lastName;
  final int? phoneNumber;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _firstName;
  String? _lastName;
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _firstName = widget.firstName;
    _lastName = widget.lastName;
    _phoneNumber = widget.phoneNumber?.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () async{
            final result = await
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return EditProfilePage();
                },
              ),
            );

            if(result != null) {
              setState(() {
                _firstName = (result['firstName'] ?? '').isEmpty ? null : result['firstName'];
                _lastName = (result['lastName'] ?? '').isEmpty ? null : result['lastName'];
                _phoneNumber = (result['phoneNumber'] ?? '').isEmpty ? null : result['phoneNumber'];
              });
            }
          },
          icon: Icon(IconlyBold.edit, color: Colors.grey.shade600),
        ),
        title: Title(
          color: Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
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
                    decoration: BoxDecoration(
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
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.swap_horiz_rounded,
                                  color: Color.fromRGBO(46, 23, 21, 1),
                                  size: 40,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'العربية',
                                  style: TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),
                          Divider(),
                          SizedBox(height: 20.0),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPageNotifier.value = 0;
                              });
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
                            child: Row(
                              children: [
                                Icon(
                                  IconlyLight.logout,
                                  color: Color.fromRGBO(46, 23, 21, 1),
                                  size: 40,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Log Out',
                                  style: TextStyle(
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
                'R4neem',
                style: TextStyle(
                  color: Color.fromRGBO(46, 23, 21, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                'raneememail@mail.com',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
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

              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(249, 249, 249, 1),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      offset: Offset(0, 4),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          _firstName ?? 'Not provided',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
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

              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(249, 249, 249, 1),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      offset: Offset(0, 4),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          _lastName ?? 'Not provided',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
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

              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(249, 249, 249, 1),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      offset: Offset(0, 4),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          _phoneNumber?.toString() ?? 'Not provided',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
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
}
