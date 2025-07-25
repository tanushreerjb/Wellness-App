import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Handler for when notification is tapped while app is in foreground
@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
    ) => NotificationService().onClickToNotification(
  notificationResponse.payload,
);

// Handler for when notification is tapped while app is in background/terminated
@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse,
    ) => NotificationService().onClickToNotification(
  notificationResponse.payload,
);

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initializes the local notifications plugin with platform-specific settings
  /// and sets up handlers for notification taps (both foreground and background)
  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('notification');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const DarwinInitializationSettings initializationSettingsMacOS =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );

    // Request permissions on iOS
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // Initialize the plugin and assign tap handlers
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
      onDidReceiveBackgroundNotificationResponse,
    );
  }

  void onClickToNotification(String? data) {
    log("Notification payload: $data");
  }

  /// • (message): The incoming remote message from Firebase Cloud Messaging.
  Future<void> showNotification({required RemoteMessage message}) async {
    log('local notification remote message: ${message.toMap()}');

    const String channelId = 'wellness_channel';
    const String channelName = 'Wellness Notifications';
    const String channelDesc = 'Notifications for wellness updates';

    // Generate a unique 32-bit integer ID for the notification
    final int notificationId =
        DateTime.now().millisecondsSinceEpoch % 2147483647;

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        showWhen: true,
      ), // AndroidNotificationDetails
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ), // DarwinNotificationDetails
    ); // NotificationDetails

    // Show the notification with title, body, and optional payload
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      message.notification?.title ?? message.data['title'] ?? '',
      message.notification?.body ?? message.data['body'] ?? '',
      platformChannelSpecifics,
      payload: json.encode(message.data),
    );
  }
}