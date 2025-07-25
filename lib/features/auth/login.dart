import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:show_hide_password/show_hide_password.dart';
import 'package:wellness_app/features/dashboard/dashboard.dart';
import 'package:wellness_app/features/auth/signup.dart';
import 'package:wellness_app/features/auth/authservice.dart';
import 'dart:developer'; // for log() function
import 'package:firebase_auth/firebase_auth.dart'; // UserCredential, GoogleAuthProvider, FirebaseAuth
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wellness_app/core/route/route_name.dart';
import 'package:email_validator/email_validator.dart';

import '../service/firestore_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  String role = 'customer';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final _formKey = GlobalKey<FormState>();

  // Simple email validation using email_validator package
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Simple password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  // Show error message
  void showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.white;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
          spacing: 10, //equal spacing of 10
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 360.0,
              child: Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(
              width: 370.0,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 24.0,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 370.0,
              child:
              ShowHidePassword(
                  passwordField: (bool hidePassword){
                    return  TextField(
                      controller: passwordController,
                      obscureText: hidePassword, //use the hidePassword status on obscureText to toggle the visibility
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          Icons.password_outlined,
                          size: 30.0,
                          color: Colors.white70,
                        ),
                        /*suffixIcon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,)*/
                      ),
                    );
                  }
              )
            ),

            Row(
              children: [
                SizedBox(
                  //width: 40,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    //Adding padding to checkbox
                    child: Checkbox(
                      checkColor: Colors.black,
                      fillColor: WidgetStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                ),

                Text('Remember Me'),

                const SizedBox(width: 95), //Adding space between the row elements

                TextButton(
                  onPressed: () async {
                    bool linksent = await AuthService().forgotPassword(emailController.text);
                    if (linksent){
                      log('Forgot Password linksent success');
                    } else {
                      log('Forgot Password linksent failed');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline),
                  ),
                ),

              ], //Row children
            ),
            SizedBox(
              height: 60.0,
              width: 360.0,
              child: TextButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () async {
                  // Validate email
                  String? emailError = validateEmail(emailController.text);
                  if (emailError != null) {
                    showMessage(emailError);
                    return;
                  }

                  // Validate password
                  String? passwordError = validatePassword(passwordController.text);
                  if (passwordError != null) {
                    showMessage(passwordError);
                    return;
                  }

                  // If both validations pass, proceed with login
                  UserCredential? user = await AuthService().signInWithEmailPassword(
                    emailController.text,
                    passwordController.text,
                  );

                  if (user != null) {
                    log("Login success");
                    //showMessage('Login Successful', isError: false);
                    String userId = user.user!.uid; // Get the user's UID
                    String? userRole = await FireStoreService().getUserRole(userId);

                    if (userRole != null) {
                      log("User role: $userRole");

                      // Navigate based on role
                      if (userRole == 'admin') {
                        Navigator.of(context).pushNamed(AuthRouteName.adminDashboardScreen);
                      } else if (userRole == 'customer') {
                        Navigator.of(context).pushNamed(AuthRouteName.dashboardScreen);
                      } else {
                        // Handle unknown role
                        showMessage("Unknown user role");
                      }
                    } else {
                      log("Failed to retrieve user role");
                      showMessage("Failed to retrieve user information");
                    }

                  } else {
                    log("Login failed");
                    //showMessage('Invalid Credentials');
                    showMessage("Login failed. Please check your credentials.");
                  }
                },

                child: const Text('Login',
                  style: TextStyle(color: Colors.black),),
              ),
            ),
            //const SizedBox(height: 30),

            Text('or'),

            SizedBox(
              height: 60.0,
              width: 360.0,
              child: FilledButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () async {
                  UserCredential? user = await AuthService().signInWithGoogle();
                  if (user != null && role == 'customer') {
                    log("Login success");
                    Navigator.of(
                      context,
                    ).pushNamed(AuthRouteName.dashboardScreen);
                  } else if (user != null && role == 'admin'){
                    log("Login success");
                    Navigator.of(
                      context,
                    ).pushNamed(AuthRouteName.adminDashboardScreen);
                  }
                  else {
                    log("Login failed");
                  };
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.g_mobiledata,
                      size: 35.0,
                      color: Colors.black,
                    ),
                    //const SizedBox(width: 3),
                    const Text(
                      'Login with Google',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            /*const SizedBox(height: 30),
            SizedBox(height: 0.5),*/

            Text("Don't have an account?",
                style: TextStyle(fontSize: 16)),
            // Alternative: Using TextButton
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.underline),
              ),
            ),

          ], //Children
        ),
      );
  }
}
