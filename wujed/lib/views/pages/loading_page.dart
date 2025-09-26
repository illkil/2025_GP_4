import 'package:flutter/material.dart';
import 'package:wujed/views/pages/language_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LanguagePage();
            },
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(46, 23, 21, 1),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Image.asset('lib/assets/images/LogoArabic.png')),
            Positioned(
              bottom: 40,
              left: 145,
              child: Text(
                'Wujed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 34.0,
                  color: Color.fromRGBO(255, 204, 92, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
