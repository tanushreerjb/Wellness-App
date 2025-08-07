import 'dart:developer';
import 'dart:math' hide log;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'notification_helper.dart';

class FireStoreService {
  final String _generateUniqueId = Uuid().v4();

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
          });
    } catch (e) {
      log("Failed to add new user data [insertNewUserData] : $e");
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


  Future<void> updateUserPreferences({
    required String uuid,
    required String name,
    required List<String> preferences,
  }) async {
    try {

      for (String preference in preferences) {
        String preferenceId = Uuid().v4();
        await FirebaseFirestore.instance
            .collection("user_preferences")
            .doc(preferenceId)
            .set({
          'id': preferenceId,
          'userId': uuid, // Foreign key
          'name': name,
          'preferenceName': preference,
        });
      }

      log("User preferences updated successfully for user: $uuid");
    } catch (e) {
      log("Failed to update user preferences [updateUserPreferences] : $e");
      rethrow; // Re-throw to handle in UI
    }
  }

  // Get user preferences from separate collection
  Future<List<String>> getUserPreferences(String? uuid) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("user_preferences")
          .where('userId', isEqualTo: uuid)
          .get();


      var result = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .map((data) => data['preferenceName'] as String)
          .toList();
      log("Fetching $result");
      return result;
    } catch (e) {
      log("Failed to get user preferences [getUserPreferences] : $e");
      return [];
    }
  }

  Future<bool> addCategory({
    required String userId,
    required String categoryName,
  }) async {
    try {
      String id = _generateUniqueId;
      await FirebaseFirestore.instance
          .collection("category")
          .doc(categoryName)
          .set({'name': categoryName, 'id': id});
      return true;
    } catch (e) {
      log("Failed to add new category : $e");
      return false;
    }
  }

  Future<bool> addQuote({
    required String userId,
    required String categoryName,
    required String authorName,
    required String quoteText,
  }) async {
    try {
      String id = _generateUniqueId;

      // Add the quote to Firestore
      await FirebaseFirestore.instance
          .collection("quotes")
          .doc(id)
          .set({
        'userId': userId,
        'name': categoryName,
        'authorName': authorName,
        'quoteText': quoteText,
        'id': id,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Send notifications to users with this preference
      await NotificationHelper.sendNewQuoteNotification(
        categoryName: categoryName,
        authorName: authorName,
        quoteText: quoteText,
      );

      return true;
    } catch (e) {
      log("Failed to add new quote : $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getCategories({
    required String userId,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("category")
          .get();
      return snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      log("Failed to get user categories [getUserCategories]: $e");
      return [];
    }
  }

  Future<int> getTotalUser({
    required String userId,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .get();
      return snapshot.docs.length;
    } catch (e) {
      log("Failed to get total user count [getTotalUser]: $e");
      return 0;
    }
  }

  Future<int> getTotalCategory({
    required String userId,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("category")
          .get();
      return snapshot.docs.length;
    } catch (e) {
      log("Failed to get total category count [getTotalCategory]: $e");
      return 0;
    }
  }

  Future<int> getTotalQuote({
    required String userId,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("quotes")
          .get();
      return snapshot.docs.length;
    } catch (e) {
      log("Failed to get total quote count [getTotalQuote]: $e");
      return 0;
    }
  }

  // Get random quote for "Today's Quote" feature
  Future<Map<String, dynamic>?> getRandomQuote() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("quotes")
          .get();

      if (snapshot.docs.isEmpty) return null;

      final random = Random();
      final randomDoc = snapshot.docs[random.nextInt(snapshot.docs.length)];

      return {
        'id': randomDoc.id,
        ...randomDoc.data(),
      };
    } catch (e) {
      log("Failed to get random quote [getRandomQuote]: $e");
      return null;
    }
  }

  // Get quotes based on user preferences
  Future<List<Map<String, dynamic>>> getQuotesForUserPreferences({
    required String userId,
  }) async {
    try {
      // Get user preferences first
      final preferences = await getUserPreferences(userId);

      if (preferences.isEmpty) return [];

      // Get quotes for all user preferences
      List<Map<String, dynamic>> allQuotes = [];

      for (String preference in preferences) {
        final quotes = await getQuotesByCategory(categoryName: preference);
        allQuotes.addAll(quotes);
      }

      return allQuotes;
    } catch (e) {
      log("Failed to get quotes for user preferences: $e");
      return [];
    }
  }

  Future<bool> addToFavorites({
    required String userId,
    required String quoteId,
    required String quoteText,
    required String authorName,
    required String categoryName,
    required String userName,
  }) async {
    try {
      String favoriteId = Uuid().v4();
      await FirebaseFirestore.instance
          .collection("user_favorites")
          .doc(favoriteId)
          .set({
        'id': favoriteId,
        'userId': userId,
        'name':userName,
        'quoteId': quoteId,
        'quoteText': quoteText,
        'authorName': authorName,
        'categoryName': categoryName,
      });

      log("Quote added to favorites successfully for user: $userId");
      return true;
    } catch (e) {
      log("Failed to add quote to favorites [addToFavorites] : $e");
      return false;
    }
  }

  // Get all favorite quotes for a user
  Future<List<Map<String, dynamic>>> getUserFavorites(String userId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("user_favorites")
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      log("Failed to get user favorites [getUserFavorites] : $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getQuotesByCategory({
    required String categoryName,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("quotes")
          .where('name', isEqualTo: categoryName) // Changed from 'categoryName' to 'name'
          .get();

      return snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      log("Failed to get quotes by category [getQuotesByCategory]: $e");
      return [];
    }
  }

  Future<void> insertDataIntoPreferences({
    required String categoryName,
    required String preferenceName,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("preferences")
          .doc(preferenceName)
          .set({'categoryName': categoryName, 'name': preferenceName});
    } catch (e) {
      log("Failed to add new user data [insertNewUserData] : $e");
    }
  }

  Future<List<Map<String, dynamic>>> getUsersWithPreference(String preferenceName) async {
    try {
      // Get all users who have this preference
      QuerySnapshot preferenceSnapshot = await FirebaseFirestore.instance
          .collection("user_preferences")
          .where('preferenceName', isEqualTo: preferenceName)
          .get();

      List<String> userIds = preferenceSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .map((data) => data['userId'] as String)
          .toList();

      if (userIds.isEmpty) return [];

      // Get user details including FCM tokens
      List<Map<String, dynamic>> users = [];
      for (String userId in userIds) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
          if (userData['fcmToken'] != null) {
            users.add({
              'userId': userId,
              'fcmToken': userData['fcmToken'],
              'name': userData['name'],
            });
          }
        }
      }

      return users;
    } catch (e) {
      log("Failed to get users with preference: $e");
      return [];
    }
  }

// Store pending notifications for offline users
  Future<void> storePendingNotification({
    required String userId,
    required String title,
    required String body,
    required String categoryName,
  }) async {
    try {
      String notificationId = Uuid().v4();
      await FirebaseFirestore.instance
          .collection("pending_notifications")
          .doc(notificationId)
          .set({
        'id': notificationId,
        'userId': userId,
        'title': title,
        'body': body,
        'categoryName': categoryName,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
      });
    } catch (e) {
      log("Failed to store pending notification: $e");
    }
  }

// Get pending notifications for a user
  Future<List<Map<String, dynamic>>> getPendingNotifications(String userId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("pending_notifications")
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      log("Failed to get pending notifications: $e");
      return [];
    }
  }

// Mark notifications as read
  Future<void> markNotificationsAsRead(String userId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("pending_notifications")
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (DocumentSnapshot doc in snapshot.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();
    } catch (e) {
      log("Failed to mark notifications as read: $e");
    }
  }
}

