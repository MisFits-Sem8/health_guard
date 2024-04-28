import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:logger/logger.dart';

class NotificationService {
  final Logger _logger = Logger();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final StreamController<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      StreamController<ReceivedNotification>.broadcast();

  final StreamController<String?> selectNotificationSubject =
      StreamController<String?>.broadcast();

  String? selectedNotificationPayload;

  // Private constructor
  NotificationService._privateConstructor();

  // Static variable for holding the singleton instance
  static final NotificationService _instance =
      NotificationService._privateConstructor();

  // Factory constructor that returns the singleton instance
  factory NotificationService() {
    return _instance;
  }

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future<void> showNotification() async {
  //   _logger.d('show notification event fired');
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           showWhen: false);
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(0, 'Successful Login',
  //       'You have logged in successfully', platformChannelSpecifics);
  // }
  Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, 'Successful Login',
        'You have logged in successfully', notificationDetails,
        payload: 'item x');
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
