import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FireStoreService {
  // final String _generateUniqueID = Uuid().v4();

  Future<void> insertNewUserData({
    required String email,
    required String name,
    required String uuid,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("users") //Collection or Table in database
          .doc(uuid)
          .set({
            'email': email,
            'name': name,
            'userRole': 'customer',
            'preferences': [],
          });
    } catch (e) {
      log("Failed to add new user data [insertNewUserData] : $e");
    }
  }

  Future<void> updateUserPreferences({
    required String uuid,
    required List<String> preferences,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(uuid).update({
        'preferences': preferences,
      });
    } catch (e) {
      log("Failed to update user preferences [updateUserPreferences] : $e");
    }
  }

  // Method to get user role by UUID
  Future<String?> getUserRole(String uuid) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uuid)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data['userRole'] as String?;
      } else {
        log("User document does not exist for UUID: $uuid");
        return null;
      }
    } catch (e) {
      log("Failed to get user role [getUserRole] : $e");
      return null;
    }
  }

  // Alternative method to get full user data
  Future<Map<String, dynamic>?> getUserData(String uuid) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uuid)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        log("User document does not exist for UUID: $uuid");
        return null;
      }
    } catch (e) {
      log("Failed to get user data [getUserData] : $e");
      return null;
    }
  }
}
