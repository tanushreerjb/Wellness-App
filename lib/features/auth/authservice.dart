import 'dart:developer'; // for log() function
import 'package:firebase_auth/firebase_auth.dart'; // UserCredential, GoogleAuthProvider, FirebaseAuth
import 'package:google_sign_in/google_sign_in.dart'; // GoogleSignIn, GoogleSignInAccount, GoogleSignInAuthentication

class AuthService {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      log("Google authentication error: ${error}");
      return null;
    }
  }

  Future<void> googleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      log("Google sign out error: ${error.toString()}");
    }
  }
}