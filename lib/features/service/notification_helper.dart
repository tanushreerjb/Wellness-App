import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:wellness_app/features/service/firestore_service.dart';

class NotificationHelper {
  // You'll need to add this to your Firebase Console -> Project Settings -> Cloud Messaging
  static const String serverKey = 'YOUR_SERVER_KEY_HERE';

  static Future<void> sendNewQuoteNotification({
    required String categoryName,
    required String authorName,
    required String quoteText,
  }) async {
    try {
      // Get users who have this category as preference
      List<Map<String, dynamic>> users = await FireStoreService()
          .getUsersWithPreference(categoryName);

      if (users.isEmpty) {
        log("No users found with preference: $categoryName");
        return;
      }

      String title = "New Quote Added! 📖";
      String body = "A new $categoryName quote by $authorName has been added";

      // Send notifications to online users and store for offline users
      for (Map<String, dynamic> user in users) {
        try {
          // Try to send FCM notification
          bool sent = await _sendFCMNotification(
            token: user['fcmToken'],
            title: title,
            body: body,
            categoryName: categoryName,
          );

          // If FCM fails (user might be offline), store as pending notification
          if (!sent) {
            await FireStoreService().storePendingNotification(
              userId: user['userId'],
              title: title,
              body: body,
              categoryName: categoryName,
            );
          }
        } catch (e) {
          log("Failed to notify user ${user['userId']}: $e");
          // Store as pending notification on error
          await FireStoreService().storePendingNotification(
            userId: user['userId'],
            title: title,
            body: body,
            categoryName: categoryName,
          );
        }
      }

      log("Notifications sent for new quote in category: $categoryName");
    } catch (e) {
      log("Failed to send new quote notifications: $e");
    }
  }

  static Future<bool> _sendFCMNotification({
    required String token,
    required String title,
    required String body,
    required String categoryName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: json.encode({
          'to': token,
          'notification': {
            'title': title,
            'body': body,
            'sound': 'default',
          },
          'data': {
            'categoryName': categoryName,
            'type': 'new_quote',
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          'android': {
            'priority': 'high',
            'notification': {
              'channel_id': 'wellness_channel',
              'sound': 'default',
            },
          },
          'apns': {
            'payload': {
              'aps': {
                'sound': 'default',
                'badge': 1,
              },
            },
          },
        }),
      );

      if (response.statusCode == 200) {
        log("FCM notification sent successfully");
        return true;
      } else {
        log("Failed to send FCM notification: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Error sending FCM notification: $e");
      return false;
    }
  }
}