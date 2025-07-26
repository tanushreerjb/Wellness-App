import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:wellness_app/features/service/authservice.dart';
import 'package:wellness_app/features/auth/login.dart';
import 'package:wellness_app/features/auth/signup.dart';
import 'package:wellness_app/features/service/authservice.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      body:Padding(
        padding: EdgeInsets.all(25.0),
      child: Column(
        spacing: 40,
        children: [
          Text('Profile', textAlign: TextAlign.start),
          Row(
            spacing: 10.0,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/images/Tanushree.JPG'),
              ),

              Column(
                children: [
                  SizedBox(
                    child: Text(
                      'Tanushree Rajbhandari',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),

                  SizedBox(child: Text('tanushree.rjb25@gmail.com',
                  style: TextStyle(decoration: TextDecoration.underline),)),
                ],
              ),
            ], //MAIN body (ROW)
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'MAKE IT YOURS',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(
            height: 60.0,
            width: 360.0,
            child: FilledButton.icon(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                backgroundColor: WidgetStatePropertyAll(Colors.white30),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              onPressed: () {},
              icon: Icon(
                Icons.menu_book_outlined,
                size: 20,
                color: Colors.white,
              ),
              label: Text(
                'Content preferences',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ACCOUNT',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(
            height: 60.0,
            width: 360.0,
            child: FilledButton.icon(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                backgroundColor: WidgetStatePropertyAll(Colors.white30),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {},
              icon: Icon(
                Icons.add_circle_outline,
                size: 20,
                color: Colors.white,
              ),
              label: Text('Theme', style: TextStyle(color: Colors.white)),
            ),
          ),

          SizedBox(
            height: 60.0,
            width: 360.0,
            child: FilledButton.icon(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                backgroundColor: WidgetStatePropertyAll(Colors.white30),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {},
              icon: Icon(
                Icons.password_outlined,
                size: 20,
                color: Colors.white,
              ),
              label: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          SizedBox(
            height: 60.0,
            width: 360.0,
            child: FilledButton.icon(
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                backgroundColor: WidgetStatePropertyAll(Colors.white30),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () async {
                await AuthService().signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(Icons.login, size: 20, color: Colors.white),
              label: Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
