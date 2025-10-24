import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wujed/main.dart';
import 'package:wujed/views/pages/onboarding_page.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  Future<void> _saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferredLanguage', lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لغتك',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 175, 0, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' اختر',
                  style: TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose Your ',
                  style: TextStyle(
                    color: Color.fromRGBO(46, 23, 21, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Language',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 175, 0, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.0),
            FilledButton(
              onPressed: () async {
                await _saveLanguage('ar');
                MyApp.of(context)!.setLocale(const Locale('ar'));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OnboardingPage();
                    },
                  ),
                  (route) => false,
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'العربية',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 40.0),
            FilledButton(
              onPressed: () async {
                await _saveLanguage('en');
                MyApp.of(context)!.setLocale(const Locale('en'));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OnboardingPage();
                    },
                  ),
                  (route) => false,
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color.fromRGBO(46, 23, 21, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'English',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
