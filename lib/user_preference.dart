import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:wellness_app/features/dashboard/dashboard.dart';

class UserpreferencePage extends StatefulWidget {
  const UserpreferencePage({super.key});

  @override
  State<UserpreferencePage> createState() => _UserpreferencePageState();
}

class _UserpreferencePageState extends State<UserpreferencePage> {
  bool isChecked = false;
  bool var1 = false;
  bool var2 = false;
  bool var3 = false;
  bool var4 = false;
  bool var5 = false;
  bool var6 = false;
  bool var7 = false;
  bool var8 = false;
  bool var9 = false;
  bool var10 = false;

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
        spacing: 30, //equal spacing of 10
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SizedBox(
            // height: 720,
            width: 300,
            child: Text(
              'Select all topics that motivates you!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),

          Column(
            spacing: 12.5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var1
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var1 = !var1;
                        });
                      }, //onPressed

                      child: Text(
                        'Hard Times',
                        style: TextStyle(
                          color: var1 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var2
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var2 = !var2;
                        });
                      }, //onPressed

                      child: Text(
                        'Working Out',
                        style: TextStyle(
                          color: var2 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ], //Children
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var3
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var3 = !var3;
                        });
                      }, //onPressed

                      child: Text(
                        'Productivity',
                        style: TextStyle(
                          color: var3 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var4
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var4 = !var4;
                        });
                      }, //onPressed

                      child: Text(
                        'Self-esteem',
                        style: TextStyle(
                          color: var4 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var5
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var5 = !var5;
                        });
                      }, //onPressed

                      child: Text(
                        'Achieving goals',
                        style: TextStyle(
                          color: var5 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var6
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var6 = !var6;
                        });
                      }, //onPressed

                      child: Text(
                        'Inspiration',
                        style: TextStyle(
                          color: var6 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var7
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var7 = !var7;
                        });
                      }, //onPressed

                      child: Text(
                        'Letting Go',
                        style: TextStyle(
                          color: var7 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var8
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var8 = !var8;
                        });
                      }, //onPressed

                      child: Text(
                        'Love',
                        style: TextStyle(
                          color: var8 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ], //Children
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15.0,
                children: [
                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var9
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var9 = !var9;
                        });
                      }, //onPressed

                      child: Text(
                        'Relationship',
                        style: TextStyle(
                          color: var9 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: var10
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          var10 = !var10;
                        });
                      }, //onPressed

                      child: Text(
                        'Faith Spirituality',
                        style: TextStyle(
                          color: var10 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ], //Children
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()
                    ),
                  );
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              /*SizedBox(
                child: FilledButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) ==>h
                    ),
                    );
                  },
                )
              )*/


            ], //Children
          ),
        ], //Children
      ),
    );
  }
}
