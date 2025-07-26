import 'package:flutter/material.dart';

import '../users/customer/screens/profile.dart';
import '../users/customer/screens/quote.dart';

class DashboardPage extends StatefulWidget {
  //final DashboardViewModel dashboardViewModel;
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Explore',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        //automaticallyImplyLeading: false,
        actions: [
          RawMaterialButton(
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/Tanushree.JPG'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        //crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /*SizedBox(
            child: Row(
              children: [
                SizedBox(width: 23),
                Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),*/

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 180.0,
                height: 55,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'My Favorites',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              /*const SizedBox(width: 50),*/
              SizedBox(
                width: 180.0,
                height: 55,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Remind Me',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(width: 23),
              Text(
                "Today's Quote",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 370.0,
                height: 80.0,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    '"Your wellness is an investment, not an expense" - Author Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 370.0,
                height: 80.0,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuotePage()),
                    );
                  },
                  child: Text(
                    'Quotes',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: FilledButton.icon(
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.sunny, size: 20, color: Colors.white),
                  label: Text(
                    'Feeling Blessed',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.paid_rounded, size: 20, color: Colors.white),
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  label: Text(
                    'Pride Month',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.star_border, size: 20, color: Colors.white),
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  label: Text(
                    'Self Worth',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.ac_unit_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  label: Text('Love', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(width: 35),
              Text(
                "Health Tips",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 70.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.sunny, size: 20, color: Colors.white),
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  label: Text(
                    'Breathe to Reset',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),


        ], //Children
      ),
    );
  }
}