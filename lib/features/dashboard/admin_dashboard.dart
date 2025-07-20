import 'package:flutter/material.dart';

import '../../core/route/route_name.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
          'Admin Dashboard',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(25.0),

        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    spacing: 150,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.account_circle_outlined, size: 50),

                      Column(
                        spacing: 7,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Users'),
                          Text(
                            '100000',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
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
                    spacing: 150,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        spacing: 7,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Category'),
                          Text(
                            '100',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          ElevatedButton(onPressed: (){
                            Navigator.of(
                              context,
                            ).pushNamed(AuthRouteName.addCategoryScreen);
                          },
                          child: Text("+", style: TextStyle(fontSize: 24, color: Colors.white),),),
                          Text('Add New'),
                        ],
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
                    spacing: 150,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        spacing: 7,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Quotes'),
                          Text(
                            '200',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          ElevatedButton(onPressed: (){
                            Navigator.of(
                              context,
                            ).pushNamed(AuthRouteName.addQuoteScreen);
                          },
                            child: Text("+", style: TextStyle(fontSize: 24, color: Colors.white),),),
                          Text('Add New'),
                        ],
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
                    spacing: 150,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        spacing: 7,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Health Tips'),
                          Text(
                            '200',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          ElevatedButton(onPressed: (){
                            Navigator.of(
                              context,
                            ).pushNamed(AuthRouteName.healthTipsScreen);
                          },
                            child: Text("+", style: TextStyle(fontSize: 24, color: Colors.white),),),
                          Text('Add New'),
                        ],
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
