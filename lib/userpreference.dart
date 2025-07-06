import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class UserpreferencePage extends StatefulWidget {
  const UserpreferencePage({super.key});

  @override
  State<UserpreferencePage> createState() => _UserpreferencePageState();
}

class _UserpreferencePageState extends State<UserpreferencePage> {
  bool isChecked = false;
  bool isPressed = false;

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
                        backgroundColor: isPressed
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      }, //onPressed

                      child: Text(
                        'Hard Times',
                        style: TextStyle(
                          color: isPressed ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: isPressed
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      }, //onPressed

                      child: Text(
                        'Hard Times',
                        style: TextStyle(
                          color: isPressed ? Colors.black : Colors.white,
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
                        backgroundColor: isPressed
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      }, //onPressed

                      child: Text(
                        'Hard Times',
                        style: TextStyle(
                          color: isPressed ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: isPressed
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      }, //onPressed

                      child: Text(
                        'Hard Times',
                        style: TextStyle(
                          color: isPressed ? Colors.black : Colors.white,
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
                        backgroundColor: isPressed
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      }, //onPressed

                      child: Text(
                        'Hard Times',
                        style: TextStyle(
                          color: isPressed ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: isPressed
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      }, //onPressed

                      child: Text(
                        'Hard Times',
                        style: TextStyle(
                          color: isPressed ? Colors.black : Colors.white,
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
                        backgroundColor: isPressed
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          isPressed = !isPressed;
                        });
                      }, //onPressed

                      child: Text(
                        'Hard Times',
                        style: TextStyle(
                          color: isPressed ? Colors.black : Colors.white,
                        ),
                      ),
                    ),

                  ),
                ], //Children

              ),
            ], //Children
          ),
        ],//Children
      ),
    );
  }
}
