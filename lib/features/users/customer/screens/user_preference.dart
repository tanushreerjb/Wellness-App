import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:wellness_app/features/dashboard/customer_dashboard.dart';

import '../../../../core/route/route_name.dart';
import 'package:wellness_app/features/service/firestore_service.dart';

class UserpreferencePage extends StatefulWidget {
  const UserpreferencePage({super.key});

  @override
  State<UserpreferencePage> createState() => _UserpreferencePageState();
}

class _UserpreferencePageState extends State<UserpreferencePage> {
  // List of preference topics
  bool isLoading = false;
  bool isChecked = false;

  List<bool> preferences = List.filled(10, false);

  // Add FireStoreService instance
  final FireStoreService _fireStoreService = FireStoreService();

  final List<String> topics = [
    'Hard Times',
    'Working Out',
    'Productivity',
    'Self-esteem',
    'Achieving goals',
    'Inspiration',
    'Letting Go',
    'Love',
    'Relationship',
    'Faith Spirituality',
  ];

  @override
  void initState() {
    super.initState();
  }

  // Modified _savePreferencesToFirebase method in UserPreferencePage:

  Future<void> _savePreferencesToFirebase() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }

      // Get selected preferences
      List<String> selectedPreferences = [];
      for (int i = 0; i < preferences.length; i++) {
        if (preferences[i]) {
          selectedPreferences.add(topics[i]);
        }
      }
      // Save preferences to separate collection using the modified FireStoreService

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      String username = '';
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        username = userData['name'] ?? user.displayName ?? 'Unknown';
      } else {
        username = user.displayName ?? 'Unknown';
      }
      await FireStoreService().updateUserPreferences(
        uuid: user.uid,
        name: username, // Pass the username
        preferences: selectedPreferences,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preferences saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to dashboard
      Navigator.of(context).pushNamed(AuthRouteName.dashboardScreen);

    } catch (e) {
      log("Failed to save preferences: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save preferences: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
          '',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        //automaticallyImplyLeading: false,

      ),
      body: Column(
        spacing: 80, //equal spacing of 10
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,

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
            spacing: 13,
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
                        backgroundColor: preferences[0]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[0] = !preferences[0];
                        });
                      }, //onPressed

                      child: Text(
                        'Hard Times',
                        style: TextStyle(
                          color: preferences[0] ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: preferences[1]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[1] = !preferences[1];
                        });
                      }, //onPressed

                      child: Text(
                        'Working Out',
                        style: TextStyle(
                          color: preferences[1] ? Colors.black : Colors.white,
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
                        backgroundColor: preferences[2]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[2] = !preferences[2];
                        });
                      }, //onPressed

                      child: Text(
                        'Productivity',
                        style: TextStyle(
                          color: preferences[2] ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: preferences[3]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[3] = !preferences[3];
                        });
                      }, //onPressed

                      child: Text(
                        'Self-esteem',
                        style: TextStyle(
                          color: preferences[3] ? Colors.black : Colors.white,
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
                        backgroundColor: preferences[4]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[4] = !preferences[4];
                        });
                      }, //onPressed

                      child: Text(
                        'Achieving goals',
                        style: TextStyle(
                          color: preferences[4] ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: preferences[5]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[5] = !preferences[5];
                        });
                      }, //onPressed

                      child: Text(
                        'Inspiration',
                        style: TextStyle(
                          color: preferences[5] ? Colors.black : Colors.white,
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
                        backgroundColor: preferences[6]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[6] = !preferences[6];
                        });
                      }, //onPressed

                      child: Text(
                        'Letting Go',
                        style: TextStyle(
                          color: preferences[6] ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: preferences[7]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[7] = !preferences[7];
                        });
                      }, //onPressed

                      child: Text(
                        'Love',
                        style: TextStyle(
                          color: preferences[7] ? Colors.black : Colors.white,
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
                        backgroundColor: preferences[8]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[8] = !preferences[8];
                        });
                      }, //onPressed

                      child: Text(
                        'Relationship',
                        style: TextStyle(
                          color: preferences[8] ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: 175,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: preferences[9]
                            ? Colors.white
                            : Colors.white30,
                      ),
                      onPressed: () {
                        setState(() {
                          preferences[9] = !preferences[9];
                        });
                      }, //onPressed

                      child: Text(
                        'Faith Spirituality',
                        style: TextStyle(
                          color: preferences[9] ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ], //Children
              ),
            ], //Children
          ),

          //SizedBox(width: 100,),
          FilledButton(
            onPressed: isLoading ? null : _savePreferencesToFirebase, // Updated to use the save method
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
              'Continue',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ], //Children
      ),
    );
  }
}