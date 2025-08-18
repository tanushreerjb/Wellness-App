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
    _loadUserPreferences();
  }

  // Load existing user preferences from database
  Future<void> _loadUserPreferences() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        List<String> savedPreferences = await _fireStoreService.getUserPreferences(user.uid);

        setState(() {
          // Reset all preferences first
          preferences = List.filled(10, false);

          // Set saved preferences to true
          for (String savedPref in savedPreferences) {
            int index = topics.indexOf(savedPref);
            if (index != -1) {
              preferences[index] = true;
            }
          }
        });
      }
    } catch (e) {
      log("Failed to load user preferences: $e");
    }
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

      // Navigate back to dashboard and refresh it
      Navigator.of(context).pushNamed(
          AuthRouteName.dashboardScreen);

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

  Widget _buildPreferenceButton(int index) {
    return SizedBox(
      height: 50,
      width: 175,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: preferences[index]
              ? Colors.white
              : Colors.white.withOpacity(0.2),
          side: preferences[index]
              ? BorderSide(color: Colors.grey.shade300, width: 1)
              : BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
          elevation: preferences[index] ? 4 : 0,
        ),
        onPressed: () {
          setState(() {
            preferences[index] = !preferences[index];
          });
        },
        child: Text(
          topics[index],
          style: TextStyle(
            color: preferences[index] ? Colors.black : Colors.white,
            fontWeight: preferences[index] ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 80,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
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
              spacing: 15,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton(0), // Hard Times
                    _buildPreferenceButton(1), // Working Out
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton(2), // Productivity
                    _buildPreferenceButton(3), // Self-esteem
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton(4), // Achieving goals
                    _buildPreferenceButton(5), // Inspiration
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton(6), // Letting Go
                    _buildPreferenceButton(7), // Love
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton(8), // Relationship
                    _buildPreferenceButton(9), // Faith Spirituality
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: FilledButton(
                onPressed: isLoading ? null : _savePreferencesToFirebase,
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
            ),
          ],
        ),
      ),
    );
  }
}