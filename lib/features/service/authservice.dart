import 'dart:developer'; // for log() function
import 'package:firebase_auth/firebase_auth.dart'; // UserCredential, GoogleAuthProvider, FirebaseAuth
import 'package:google_sign_in/google_sign_in.dart'; // GoogleSignIn, GoogleSignInAccount, GoogleSignInAuthentication

class AuthService {
  // Google Sign In
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

  // Email/Password Sign Up
  Future<UserCredential?> signUpWithEmailPassword(String email, String password, String username) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update the user's display name with the username
      await userCredential.user?.updateDisplayName(username);

      return userCredential;
    } catch (error) {
      log("Email/password sign up error: ${error}");
      return null;
    }
  }

  // Email/Password Sign In
  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (error) {
      log("Email/password sign in error: ${error}");
      return null;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      log("Password reset email sent successfully to: $email");
      return true;
    } catch (error) {
      log("Forgot password error: ${error}");
      return false;
    }
  }


  // General Sign Out (works for both Google and Email/Password)
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut(); // Also sign out from Google if previously signed in
    } catch (error) {
      log("Sign out error: ${error.toString()}");
    }
  }

  // Get current user
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  // Check if user is signed in
  bool isSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  // Stream of auth state changes
  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();
}