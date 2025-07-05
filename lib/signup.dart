import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
        spacing: 20,
        //equal spacing of 10
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
                child: Padding(padding: EdgeInsets.only(left:10.0),//Adding padding to checkbox
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

              const Text('Forgot Password?', textAlign: TextAlign.right,),
            ], //Row children
          ),
          SizedBox(
            height: 60.0,
            width: 360.0,
            child: FilledButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: () {},
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
          const SizedBox(height: 30),

          Text('Already have an account? Login'),
        ], //Children
      ),
    );
  }
}
