import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/firestore_service.dart';
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
  bool isLoading = false;
  List<String> userPreference = [];

  @override
  void initState(){
    super.initState();
    loadDashboardData();
  }

  Future <void> loadDashboardData() async{
    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        log(user.uid);
        final preferences = await FireStoreService().getUserPreferences(user.uid);
        setState(() {
          userPreference = preferences;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error loading dashboard data: $e');
      setState(() {
        isLoading = false;
        // Optionally set userPreference to empty list or show error state
        userPreference = [];
      });
    }
  }

  IconData _getIconForPreference(String preference) {
    switch (preference.toLowerCase()) {
      case 'hard times':
        return Icons.heart_broken_rounded;
      case 'working out':
        return Icons.run_circle_outlined;
      case 'productivity':
        return Icons.trending_up;
      case 'self-esteem':
        return Icons.self_improvement;
      case 'achieving goals':
        return Icons.emoji_events;
      case 'inspiration':
        return Icons.lightbulb_outline_rounded;
      case 'letting go':
        return Icons.handshake;
      case 'love':
        return Icons.favorite_border_sharp;
      case 'relationship':
        return Icons.family_restroom_outlined;
      case 'faith spirituality':
        return Icons.church_outlined;
      default:
        return Icons.star_border;
    }
  }

  Widget _buildPreferenceButton(String preference) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: SizedBox(
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
          onPressed: () {
            // Navigate to quotes filtered by this preference/category
            _navigateToQuotesByCategory(preference);
          },
          icon: Icon(_getIconForPreference(preference), size: 25, color: Colors.white),
          label: Text(
            preference,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _navigateToQuotesByCategory(String categoryName) {
    // Navigate to quotes page with category filter
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuotePage(categoryFilter: categoryName),
      ),
    );
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
            children: [
              SizedBox(width: 35),
              Text(
                "Quotes",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Dynamic user preferences section
          if (userPreference.isNotEmpty) ...[
            Column(
              children: userPreference
                  .map((preference) => _buildPreferenceButton(preference))
                  .toList(),
            ),
          ]
          else ...[
            // Show default categories if no preferences set
            SizedBox(height: 10,),
            Column(
              children: [
                Text("No Preferences Selected!")
              ],
            ),
          ],

          SizedBox(height: 10,),
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