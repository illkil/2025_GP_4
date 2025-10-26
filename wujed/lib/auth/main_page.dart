import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wujed/auth/google_auth.dart';
import 'package:wujed/views/pages/login_page.dart';
import 'package:wujed/views/widget_tree.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //waiting for Firebase to load user state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 175, 0, 1),
                ),
              ),
            );
          }

          //User not signed in then Go to Loading Page as if it is a new user using Wujed
          if (!snapshot.hasData) {
            return const LoginPage();
          }

          //User signed in
          final user = snapshot.data!;

          //User not verified then Log out and go to Login
          if (!user.emailVerified) {
            return LoginPage();
          }

          // return FutureBuilder<String?>(
          //   future: FirebaseAppCheck.instance.getToken(),
          //   builder: (context, tokenSnapshot) {
          //     if (tokenSnapshot.connectionState == ConnectionState.waiting) {
          //       return Container(
          //         color: Colors.white,
          //         child: const Center(
          //           child: CircularProgressIndicator(
          //             color: Color.fromRGBO(255, 175, 0, 1),
          //           ),
          //         ),
          //       );
          //     }

          //     //If token is null or invalid logout & go to Login
          //     if (!tokenSnapshot.hasData || tokenSnapshot.data!.isEmpty) {
          //       if (GoogleSignInService.getCurrentUser() != null) {
          //         GoogleSignInService.signOut();
          //       }
          //       FirebaseAuth.instance.signOut();
          //       return const LoginPage();
          //     }

          //     //User signed in & verified then Go to app
          //     return const WidgetTree();
          //   },
          // );

          //User signed in & verified then Go to app
          return const WidgetTree();
        },
      ),
    );
  }
}
