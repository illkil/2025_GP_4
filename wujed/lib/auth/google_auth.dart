import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Google Sign-In Service Class
class GoogleSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialize = false;

  static Future<void> initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
        serverClientId:
            '85687027651-lj9pn2q2i8kgsb8ge5p4mthdeo6ebafp.apps.googleusercontent.com',
      );
    }
    isInitialize = true;
  }

  // Sign in with Google
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      initSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(['email', 'profile']);
      final accessToken = authorization?.accessToken;
      if (accessToken == null) {
        final authorization2 = await authorizationClient.authorizationForScopes(
          ['email', 'profile'],
        );
        if (authorization2?.accessToken == null) {
          throw FirebaseAuthException(code: "error", message: "error");
        }
        authorization = authorization2;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        final username = (user.displayName ?? 'user')
            .trim()
            .toLowerCase()
            .replaceAll(RegExp(r'[^a-zA-Z0-9._]'), '');

        final uniqueUsername = await generateUniqeUsername(username);

        final prefs = await SharedPreferences.getInstance();
        final String? lang = prefs.getString('preferredLanguage');

        final userDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);
        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'uid': user.uid,
            'username': uniqueUsername,
            'email': user.email,
            'first_name': '',
            'last_name': '',
            'phone_number': '',
            'role':
                'user', //this might be a security concern, stating the user role in client side is wrong its better to do it in server side somehow, i'll check it later
            'language': lang ?? 'en',
            'created_at': Timestamp.now(),
          });
        }
      }
      return userCredential;
    } catch (e) {
      //check if the user canceled the flow
      if (e.toString().contains('sign_in_failed') ||
          e.toString().contains('canceled') ||
          e.toString().contains('user canceled')) {
        print('Google sign-in canceled by user.');
        return null;
      }

      //fFor other unexpected errors
      print('Google sign-in error: $e');
      return null;
    }
  }

  static Future<String> generateUniqeUsername(String username) async {
    final userRef = FirebaseFirestore.instance.collection('users');
    final random = Random();
    String newUsername = username;
    bool exist = true;

    while (exist) {
      final randomNumbers = random.nextInt(90000) + 10000;
      newUsername = '$username$randomNumbers';

      final snapshot = await userRef
          .where('username', isEqualTo: newUsername)
          .limit(1)
          .get();

      exist = snapshot.docs.isNotEmpty;
    }

    return newUsername;
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      throw e;
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}
