import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('lib/assets/images/LogoArabic.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to ',
                  style: TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Wujed',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 175, 0, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.0),

            Text(
              'Every lost item has a way back home. With\nWujed, you can find what’s missing or help\nreturn what’s found.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(46, 23, 21, 1),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 200.0),
          ],
        ),
      ),
    );
  }
}
