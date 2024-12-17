import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:palenque_application/pages/service_pages/home.dart';
import 'package:palenque_application/pages/auth_pages/login.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Email and Password Registration
  Future<void> registerWithEmailandPassword(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      }
    } catch (e) {
      _handleError(context, e);
    }
  }

  // Email and Password Sign-In
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
    } catch (e) {
      _handleError(context, e);
    }
  }

  // Google Sign-In
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      if (gUser == null) {
        return;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
    } catch (e) {
      _handleError(context, e);
    }
  }

  // Facebook Sign In

  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Log out from Facebook to clear any previous session
      await FacebookAuth.instance.logOut();

      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
                loginResult.accessToken!.tokenString);
        return await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      } else if (loginResult.status == LoginStatus.cancelled) {
        print('Facebook login was canceled by the user.');
      } else {
        print('Facebook login failed with status: ${loginResult.status}');
      }
    } catch (e) {
      print('An error occurred during Facebook login: $e');
    }

    return null;
  }

  // Auth Sign-Out
  Future<void> signOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } catch (e) {
      _handleError(context, e);
    }
  }

  // Error Handling
  void _handleError(BuildContext context, Object error) {
    String message;

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          message = "This email is already in use.";
          break;
        case 'invalid-email':
          message = "The email address is invalid.";
          break;
        case 'weak-password':
          message = "The password is too weak.";
          break;
        case 'user-not-found':
          message = "No user found with this email.";
          break;
        case 'wrong-password':
          message = "Incorrect password.";
          break;
        default:
          message = "An unexpected error occurred. Please try again.";
      }
    } else {
      message = "An error occurred. Please try again.";
    }

    // Show the error dialog
    _showErrorDialog(context, message);
  }

  // Show Error Dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
