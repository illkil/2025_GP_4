import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MatchAfterAcceptingPage extends StatefulWidget {
  const MatchAfterAcceptingPage({super.key});

  @override
  State<MatchAfterAcceptingPage> createState() =>
      _MatchAfterAcceptingPageState();
}

class _MatchAfterAcceptingPageState extends State<MatchAfterAcceptingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Title(
          color: Color.fromRGBO(46, 23, 21, 1),
          child: Text(
            'Coffee Brewer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250.0,
                width: 250.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('lib/assets/images/CoffeeBrew2.jpg'),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.0),

              Row(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                      color: Color.fromRGBO(43, 23, 21, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),

              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 20,
                      child: Icon(
                        IconlyBold.location,
                        color: Color.fromRGBO(46, 23, 21, 1),
                        size: 37,
                      ),
                    ),
                    Positioned(
                      top: 18,
                      left: 100,
                      child: Text(
                        'XYZLOCATIONXYZXYZXYZ',
                        style: TextStyle(
                          color: Color.fromRGBO(46, 23, 21, 1),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 10,

                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                          color: Color.fromRGBO(46, 23, 21, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.0),

              Row(
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Color.fromRGBO(43, 23, 21, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.0),

              Container(
                height: 169,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
                    style: TextStyle(
                      color: Color.fromRGBO(46, 23, 21, 1),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: ()  async{
                      final done = await showDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierColor: Colors.black54,
                        builder: (_) => AlertDialog(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                          alignment: Alignment.center,
                          titlePadding: const EdgeInsets.fromLTRB(
                            20,
                            20,
                            20,
                            0,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20,
                            10,
                            20,
                            20,
                          ),
                          actionsPadding: const EdgeInsets.fromLTRB(
                            20,
                            0,
                            20,
                            20,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Congratulations!',
                                style: TextStyle(
                                  color: Color.fromRGBO(46, 23, 21, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          content: Text(
                            'You got your item back!\nEnjoy having it safe and sound again',
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment: MainAxisAlignment.end,
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context, 'Continue');
                              },
                              style: FilledButton.styleFrom(
                                minimumSize: Size(double.infinity, 45),
                                backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

    
                          ],
                        ),
                      );
                      if (done == 'Continue') {
                        if (!mounted) return;
                        Navigator.pop(context);
                        Navigator.pop(
                          context,
                          'Done',
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: Size(170, 45),
                      backgroundColor: Color.fromRGBO(101, 166, 91, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Confirm Receipt',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  SizedBox(width: 10.0),

                  FilledButton(
                    onPressed: () async {
                      final confirmed = await showDialog<String>(
                        context: context,
                        barrierDismissible: true,
                        barrierColor: Colors.black54,
                        builder: (_) => AlertDialog(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                          alignment: Alignment.center,
                          titlePadding: const EdgeInsets.fromLTRB(
                            20,
                            20,
                            20,
                            0,
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(
                            20,
                            10,
                            20,
                            20,
                          ),
                          actionsPadding: const EdgeInsets.fromLTRB(
                            20,
                            0,
                            20,
                            20,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Are you sure?',
                                style: TextStyle(
                                  color: Color.fromRGBO(46, 23, 21, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          content: Text(
                            'This match will be removed permanently. Continue only if you\'re sure it\'s not your item.',
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment: MainAxisAlignment.end,
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context, 'Confirm');
                              },
                              style: FilledButton.styleFrom(
                                minimumSize: Size(double.infinity, 45),
                                backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            SizedBox(height: 10.0),

                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context, 'Cancel');
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size(double.infinity, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color.fromRGBO(46, 23, 21, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == 'Confirm') {
                        if (!mounted) return;
                        Navigator.pop(context, 'Revoked');
                      }
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: Size(170, 45),
                      backgroundColor: Color.fromRGBO(166, 91, 91, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Revoke',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
