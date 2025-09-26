import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:wujed/views/pages/item_reported_lost.dart';
import 'package:wujed/views/pages/notifications_page.dart';
import 'package:wujed/views/pages/report_found_page.dart';
import 'package:wujed/views/pages/report_lost_page.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/bi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 280.0,
            color: Color.fromRGBO(255, 204, 92, 0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset('lib/assets/images/Logo.png'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NotificationsPage();
                              },
                            ),
                          );
                        },
                        icon: Stack(
                          children: [
                            Icon(
                              IconlyBold.notification,
                              color: Color.fromRGBO(46, 23, 21, 1),
                              size: 40,
                            ),
                            Positioned(
                              right: 3,
                              top: 0,
                              child: Icon(
                                Icons.circle,
                                color: Color.fromRGBO(255, 0, 0, 1),
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'What item are you reporting?',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
          
                SizedBox(height: 30.0),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ReportLostPage();
                            },
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size(150.0, 40.0),
                        backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Lost',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
          
                    SizedBox(width: 20.0),
          
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ReportFoundPage();
                            },
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size(150.0, 40.0),
                        backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Found',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Wujed ',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 175, 0, 1),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'in numbers',
                      style: TextStyle(
                        color: Color.fromRGBO(46, 23, 21, 1),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25.0),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 200.0,
                        width: 190,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                offset: Offset(0, 4),
                                blurRadius: 16,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 20,
                                left: 15,
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 204, 92, 0.4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Iconify(
                                    MaterialSymbols.fact_check_rounded,
                                    size: 37,
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                left: 85,
                                child: Text(
                                  'Reports\nSubmitted',
                                  style: TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 80,
                                  width: 145,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 204, 92, 0.4),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Align(
                                    alignment: Alignment(0, 0),
                                    child: Text(
                                      '2100+',
                                      style: TextStyle(
                                        color: Color.fromRGBO(46, 23, 21, 1),
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 20.0),

                      SizedBox(
                        height: 200.0,
                        width: 190,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                offset: Offset(0, 4),
                                blurRadius: 16,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 20,
                                left: 15,
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 204, 92, 0.4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Iconify(
                                    Ri.hand_coin_fill,
                                    size: 37,
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                left: 85,
                                child: Text(
                                  'Items\nRecovered',
                                  style: TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 80,
                                  width: 145,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 204, 92, 0.4),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Align(
                                    alignment: Alignment(0, 0),
                                    child: Text(
                                      '1600+',
                                      style: TextStyle(
                                        color: Color.fromRGBO(46, 23, 21, 1),
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 20.0),

                      SizedBox(
                        height: 200.0,
                        width: 190,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                offset: Offset(0, 4),
                                blurRadius: 16,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 20,
                                left: 15,
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 204, 92, 0.4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Iconify(
                                    Bi.stars,
                                    size: 37,
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                left: 85,
                                child: Text(
                                  'Matches\nFound',
                                  style: TextStyle(
                                    color: Color.fromRGBO(46, 23, 21, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 80,
                                  width: 145,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 204, 92, 0.4),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Align(
                                    alignment: Alignment(0, 0),
                                    child: Text(
                                      '1800+',
                                      style: TextStyle(
                                        color: Color.fromRGBO(46, 23, 21, 1),
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50.0),

                SizedBox(
                  height: 100.0,
                  width: 360.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          offset: Offset(0, 4),
                          blurRadius: 16,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100.0,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 80.0,
                              width: 80.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'lib/assets/images/CoffeeBrew.WEBP',
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 95,
                                  child: Text(
                                    'Coffee Brewer',
                                    style: TextStyle(
                                      color: Color.fromRGBO(46, 23, 21, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 30,
                                  left: 95,
                                  child: Text(
                                    'Check back with your\nprevious report',
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 204, 92, 0.4),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ItemReportedLost();
                                        },
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
