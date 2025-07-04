import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

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
          Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),

          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your Email',
              prefixIcon: Icon(
                Icons.email_outlined,
                size: 24.0,
                color: Colors.white70,
              ),
            ),
          ),

          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: Icon(
                Icons.password_outlined,
                size: 24.0,
                color: Colors.white70,
              ),
            ),
          ),

          Row(
            children: [
              Checkbox(
                checkColor: Colors.black,
                fillColor: WidgetStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),

              Text('Remember Me'),

              const SizedBox(width: 125),
              //Adding space between the row elements
              const Text('Forgot Password?'),
            ],
          ),
        ], //Children
      ),
    );
  }
}
