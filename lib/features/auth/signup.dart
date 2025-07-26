import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:wellness_app/features/auth/login.dart';
import 'package:wellness_app/features/users/customer/screens/user_preference.dart';
import 'package:wellness_app/features/service/authservice.dart';
import 'package:uuid/uuid.dart';
import 'package:show_hide_password/show_hide_password.dart';

import '../../core/route/route_name.dart';
import '../service/firestore_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;
  bool isChecked = false;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


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
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

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
        spacing: 20, //equal spacing of 10
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 360,
            child: Text(
              'Start your wellness journey today!',
              textAlign: TextAlign.left,
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
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Enter your Username',
                prefixIcon: Icon(
                  Icons.account_box_outlined,
                  size: 24.0,
                  color: Colors.white70,
                ),
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
            ], //Row children
          ),
          SizedBox(
            height: 60.0,
            width: 360.0,
            child: FilledButton(
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

                  setState(() {
                    isLoading = true;
                  });

                  try {
                    UserCredential? user = await AuthService().signUpWithEmailPassword(
                        emailController.text,
                        passwordController.text,
                        usernameController.text
                    );

                    if (user != null) {
                      // Store user data in Firestore (without preferences)
                      await FireStoreService().insertNewUserData(
                        email: user.user?.email ?? '',
                        name: usernameController.text, // Use username instead of email
                        uuid: user.user?.uid ?? '',
                      );

                      log("Signup success");
                      Navigator.of(context).pushNamed(AuthRouteName.userPreferenceScreen);
                    } else {
                      log("Signup failed");
                      showMessage('Signup Failed');
                    }
                  } catch (e) {
                    if (e is SocketException) {
                      showMessage('No Internet Connection. Please try again later.');
                    }
                    else if (e is TimeoutException) {
                      showMessage('Request timed out. Please try again later.');
                    }
                    else {
                      showMessage('An unknown error occurred: ${e.toString()}');
                    }
                  }
                  finally {
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
              child: const Text('Signup'),
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
              onPressed: () {},
              child: const Text('Signup with Google'),
            ),
          ),

          //const SizedBox(height: 30),
          //SizedBox(height: 0.5),
          Text('Already have an account?', style: TextStyle(fontSize: 16)),
          // Alternative: Using TextButton
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ], //Children
      ),
    );
  }
}