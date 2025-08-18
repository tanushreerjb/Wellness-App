import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../core/route/route_name.dart';
import '../service/firestore_service.dart';
import '../theme/theme_provider.dart';
import '../users/admin/screens/category_list.dart';
import '../users/admin/screens/user_list.dart';
import '../users/customer/screens/profile.dart';
import 'package:http/http.dart';

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
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        //backgroundColor: Colors.black,
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Total Users Card - Made clickable
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersListPage()),
                );
              },
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  spacing: 150,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      size: 50,
                      color: Colors.white,
                    ),
                    Column(
                      spacing: 7,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Users',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '$totalUsers',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Tap to view',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Total Categories Card - Made clickable
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesListPage()),
                );
              },
              child: Container(
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
                        Text(
                          'Total Categories',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '$totalCategories',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed(AuthRouteName.addCategoryScreen);
                          },
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                        Text(
                          'Add New',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Total Quotes Card
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
                      Text(
                        'Total Quotes',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '$totalQuotes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(AuthRouteName.addQuoteScreen);
                        },
                        child: Text(
                          "+",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                      Text(
                        'Add New',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Total Health Tips Card
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
                      Text(
                        'Total Health Tips',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '$totalHealthTips',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(AuthRouteName.healthTipsScreen);
                        },
                        child: Text(
                          "+",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                      Text(
                        'Add New',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Add some bottom padding for better scrolling experience
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}