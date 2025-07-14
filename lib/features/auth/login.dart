import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:wellness_app/features/dashboard/dashboard.dart';
import 'package:wellness_app/features/auth/signup.dart';
import 'package:wellness_app/features/auth/authservice.dart';
import 'dart:developer'; // for log() function
import 'package:firebase_auth/firebase_auth.dart'; // UserCredential, GoogleAuthProvider, FirebaseAuth
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wellness_app/core/route/route_name.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: Icon(
                  Icons.password_outlined,
                  size: 24.0,
                  color: Colors.white70,
                ),
              ),
            ),
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

              Text('Forgot Password')
            ], //Row children
          ),
          SizedBox(
            height: 60.0,
            width: 360.0,
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()
                  ),
                );
              },
              child: const Text('Login',
                style: TextStyle(color: Colors.black),),
            ),
          ),
          //const SizedBox(height: 30),

          Text('or'),

          // SizedBox(
          //   height: 60.0,
          //   width: 360.0,
          //   child: FilledButton(
          //     prefixIcon: Icon(
          //       Icons.email_outlined,
          //       size: 24.0,
          //       color: Colors.white70,
          //     ),
          //     style: const ButtonStyle(
          //       backgroundColor: WidgetStatePropertyAll(Colors.white),
          //     ),
          //     onPressed: () {},
          //     child: const Text('Login with Google'),
          //   ),
          // ),

          SizedBox(
            height: 60.0,
            width: 360.0,
            child: FilledButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: () async {
                UserCredential? user = await AuthService().signInWithGoogle();
                if (user != null) {
                  log("Login success");
                  Navigator.of(
                    context,
                  ).pushNamed(AuthRouteName.dashboardScreen);
                } else {
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
