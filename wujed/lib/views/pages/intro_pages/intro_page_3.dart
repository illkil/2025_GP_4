import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
                  'Your part ',
                  style: TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'matters',
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
              'Your reports help someone find what they’ve\nlost and together, we make a difference.',
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