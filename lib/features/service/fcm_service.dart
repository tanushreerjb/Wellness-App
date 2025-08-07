import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_service.dart';

/// A service class for managing Firebase Cloud Messaging (FCM) operations.
///
/// This class provides utility functions to initialize FCM and retrieve the
/// FCM token for the current device.
///
/// Example usage:
/// ```dart
/// final fcmService = FCMServices();
/// await fcmService.initializeCloudMessaging();
/// String? token = await fcmService.getFCMToken();
/// ```
/*
class FCMServices {
  /// Initializes Firebase Cloud Messaging for the current device.
  ///
  /// This enables FCM auto-initialization so that the device can automatically
  /// manage FCM token generation and reception of messages.
  ///
  /// Should be called early in the app lifecycle, such as during app startup.
  ///
  /// Returns a [Future] that completes when initialization is finished.
  Future<void> initializeCloudMessaging() => Future.wait([
  FirebaseMessaging.instance.requestPermission(),
    FirebaseMessaging.instance.setAutoInitEnabled(true),
  ]);

  void listenFCMMessage(){
    FirebaseMessaging.onMessage.listen(_handleFCMMessage);

    FirebaseMessaging.onBackgroundMessage(_handleFCMMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      log("Notification opened title: ${message.notification?.title}");
      log("Notification opened body: ${message.notification?.body}");
      NotificationService().onClickToNotification(
        jsonEncode({
          'title':message.notification?.title,
          'body':message.notification?.body,
        }),
      );
    });
  }

  /// Retrieves the default FCM token for the current device.
  ///
  /// This token is used to uniquely identify the device to Firebase Cloud Messaging
  /// and is necessary for sending targeted push notifications.
  ///
  /// Returns a [Future] that completes with the FCM token as a [String],
  /// or `null` if the token could not be retrieved.
  Future<String?> getFCMToken() => FirebaseMessaging.instance.getToken();

  Future <void> _handleFCMMessage(RemoteMessage message) async{
    log('Recieved FCM message title: ${message.notification?.title}');
    log('Recieved FCM message body: ${message.notification?.body}');
    await NotificationService().showNotification(message: message);
  }
}*/
class FCMServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeCloudMessaging() async {
    // Your existing implementation
    await _firebaseMessaging.requestPermission();

    // Store token when user logs in
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _storeFCMToken(user.uid);
    }
  }

  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  void listenFCMMessage() {
    // Your existing implementation
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("FCM onMessage: ${message.notification?.title}");
      // Handle foreground messages
    });
  }

  // Store FCM token for the current user
  Future<void> _storeFCMToken(String userId) async {
    try {
      String? token = await getFCMToken();
      if (token != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .update({
          'fcmToken': token,
          'lastTokenUpdate': FieldValue.serverTimestamp(),
        });
        log("FCM token stored for user: $userId");
      }
    } catch (e) {
      log("Failed to store FCM token: $e");
    }
  }

  // Call this when user logs in
  Future<void> updateFCMTokenForUser(String userId) async {
    await _storeFCMToken(userId);
  }
}
