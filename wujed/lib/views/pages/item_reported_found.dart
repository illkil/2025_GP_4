import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ItemReportedFound extends StatefulWidget {
  const ItemReportedFound({super.key});

  @override
  State<ItemReportedFound> createState() => _ItemReportedFoundState();
}

class _ItemReportedFoundState extends State<ItemReportedFound> {
  final _imgPath = 'lib/assets/images/CoffeeBrew2.jpg';
  final _heroTag = 'item-image-hero';

  void _openImage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 180),
        pageBuilder: (_, __, ___) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Stack(
              children: [
                Center(
                  child: Hero(
                    tag: _heroTag,
                    child: InteractiveViewer(
                      maxScale: 5,
                      child: Image.asset(_imgPath, fit: BoxFit.contain),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: GestureDetector(
                    onTap: () {
                      _openImage();
                    },
                    child: Image.asset(
                      'lib/assets/images/CoffeeBrew2.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: BackButton(),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 235, 190, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Text(
                          'Coffee Brewer',
                          style: TextStyle(
                            color: Color.fromRGBO(46, 23, 21, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
