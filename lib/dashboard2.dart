import 'package:flutter/material.dart';

class Dashboard2 extends StatefulWidget {
  const Dashboard2({super.key});

  @override
  State<Dashboard2> createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
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

      body: Padding(
        padding: const EdgeInsets.all(25.0),

        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    spacing: 200,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.account_circle_outlined, size: 50),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Total Users'), Text('100000')],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    spacing: 200,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total Users'),
                            Text('100000')
                          ]
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Total Users'), Text('100000')],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
