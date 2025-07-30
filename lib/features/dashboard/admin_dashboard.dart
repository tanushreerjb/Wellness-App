import 'package:flutter/material.dart';

import '../../core/route/route_name.dart';
import '../service/firestore_service.dart';
import '../users/customer/screens/profile.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int totalUsers = 0;
  int totalCategories = 0;
  int totalQuotes = 0;
  int totalHealthTips = 0;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    loadDashboardData();
  }

  Future <void> loadDashboardData() async{
    try {
      int userCount = await FireStoreService().getTotalUser(userId: "");
      int categoryCount = await FireStoreService().getTotalCategory(userId: "");
      int quoteCount = await FireStoreService().getTotalQuote(userId: "");

      setState(() {
        totalCategories = categoryCount;
        totalQuotes = quoteCount;
        totalUsers = userCount;
        totalHealthTips = userCount; //change later
        isLoading = false;
      });
    } catch (e) {
      // handle error if needed
      setState(() {
        isLoading = false;
      });
    }
  }

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
                            '$totalUsers',
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
                            '$totalCategories',
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
                            '$totalQuotes',
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
                            '$totalHealthTips',
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
