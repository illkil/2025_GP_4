import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wujed/l10n/generated/app_localizations.dart';
import 'package:wujed/views/pages/intro_pages/intro_page_1.dart';
import 'package:wujed/views/pages/intro_pages/intro_page_2.dart';
import 'package:wujed/views/pages/intro_pages/intro_page_3.dart';
import 'package:wujed/views/pages/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                onLastPage = (value == 2);
              });
            },
            children: [IntroPage1(), IntroPage2(), IntroPage3()],
          ),

          PositionedDirectional(
            top: 55,
            end: 15,
            child: TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('isFirstTime', false);
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
              child: Text(
                t.onboarding_skip,
                style: TextStyle(
                  color: Color.fromRGBO(255, 175, 0, 1),
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  decorationColor: Color.fromRGBO(255, 175, 0, 1),
                  fontSize: 18.0,
                ),
              ),
            ),
          ),

          PositionedDirectional(
            bottom: 280,
            start: 155,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 25,
                spacing: 10,
                activeDotColor: const Color.fromRGBO(255, 175, 0, 1),
                dotColor: Colors.grey.shade400,
              ),
            ),
          ),

          PositionedDirectional(
            bottom: 160,
            start: 128,
            child: SizedBox(
              height: 50.0,
              width: 150.0,
              child: onLastPage
                  ? FilledButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isFirstTime', false);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size(150.0, 50.0),
                        backgroundColor: Color.fromRGBO(255, 175, 0, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.onboarding_done,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : FilledButton(
                      onPressed: () {
                        controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size(150.0, 50.0),
                        backgroundColor: Color.fromRGBO(255, 175, 0, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.onboarding_next,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Icon(Icons.chevron_right_rounded, size: 25),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
