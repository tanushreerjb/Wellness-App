import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wellness_app/features/users/customer/screens/favorites.dart';

import '../../core/route/route_name.dart';
import '../service/fcm_service.dart';
import '../service/firestore_service.dart';
import '../service/notification_service.dart';
import '../users/customer/screens/profile.dart';
import '../users/customer/screens/quote.dart';

class DashboardPage extends StatefulWidget {
  //final DashboardViewModel dashboardViewModel;
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with WidgetsBindingObserver {
  bool isChecked = false;
  bool isLoading = false;
  List<String> userPreference = [];

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadDashboardData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh dashboard when app comes back to foreground
      loadDashboardData();
    }
  }

  Future<void> _checkPendingNotifications() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Update FCM token for current session
        await FCMServices().updateFCMTokenForUser(user.uid);

        // Get pending notifications
        List<Map<String, dynamic>> pendingNotifications =
        await FireStoreService().getPendingNotifications(user.uid);

        if (pendingNotifications.isNotEmpty) {
          // Show local notifications for pending notifications
          for (var notification in pendingNotifications) {
            await NotificationService().showLocalNotification(
              title: notification['title'],
              body: notification['body'],
              payload: json.encode({
                'categoryName': notification['categoryName'],
                'type': 'new_quote',
              }),
            );
          }

          // Mark notifications as read
          await FireStoreService().markNotificationsAsRead(user.uid);

          // Show snackbar
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${pendingNotifications.length} new quotes available!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      }
    } catch (e) {
      log('Error checking pending notifications: $e');
    }
  }

// Update your loadDashboardData method:
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

        // Check for pending notifications
        await _checkPendingNotifications();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error loading dashboard data: $e');
      setState(() {
        isLoading = false;
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
    final user = FirebaseAuth.instance.currentUser;
    if (user !=null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuotePage(categoryFilter: categoryName, userId: user.uid,),
        ),
      );
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavoritesPage()),
                      );
                    },
                    child: Text(
                      'My Favorites',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

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
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushNamed(AuthRouteName.userPreferenceScreen);
                    },
                    child: Text(
                      'Preferences',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                SizedBox(width: 7),
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
                SizedBox(width: 7),
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
            if (isLoading) ...[
              Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ]
            else
              if (userPreference.isNotEmpty) ...[
                Column(
                  children: userPreference
                      .map((preference) => _buildPreferenceButton(preference))
                      .toList(),
                ),
              ]
              else
                ...[
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        "No Preferences Selected!",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              AuthRouteName.userPreferenceScreen);
                        },
                        child: Text(
                          "Set Your Preferences",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

            Row(
              children: [
                SizedBox(width: 7),
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

            // Add some bottom padding for better scrolling experience
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  }