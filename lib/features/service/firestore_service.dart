import 'dart:developer';
import 'dart:math' hide log;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

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
      await FirebaseFirestore.instance
          .collection("quotes")
          .doc(id)
          .set({'userId': userId, 'name': categoryName, 'authorName': authorName, 'quoteText': quoteText,'id': id});
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

  Future<List<Map<String, dynamic>>> getQuotesByCategory({
    required String categoryName,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("quotes")
          .where('categoryName', isEqualTo: categoryName)
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

  Future<Map<String, dynamic>> fetchUserDataWithCategoriesAndPreferences(
      String userId,
      ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // 1. Fetch user data
      final userDoc = await firestore
          .collection("users")
          .doc(userId)
          .get();
      if (!userDoc.exists) throw Exception('User not found');

      final userData = userDoc.data()!;

      // 2. Fetch categories for the user
      final categorySnapshot = await firestore
          .collection("category")
          .where('userId', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> categoriesWithPreferences = [];

      for (var categoryDoc in categorySnapshot.docs) {
        final categoryData = categoryDoc.data();

        // 3. Fetch preferences for each category
        final preferenceSnapshot = await firestore
            .collection("preferences")
            .where('categoryName', isEqualTo: categoryData['name'])
            .get();

        final preferences = preferenceSnapshot.docs
            .map((doc) => doc.data())
            .toList();

        categoriesWithPreferences.add({
          'category': categoryData,
          'preferences': preferences,
        });
      }

      // 4. Combine user and category/preference data
      return {'user': userData, 'categories': categoriesWithPreferences};
    } catch (e) {
      log("Error fetching user data with categories and preferences: $e");
      rethrow;
    }
  }
}

