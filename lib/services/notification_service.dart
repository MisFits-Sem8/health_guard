import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:logger/logger.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final Logger _logger = Logger();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // final StreamController<ReceivedNotification>
  //     didReceiveLocalNotificationSubject =
  //     StreamController<ReceivedNotification>.broadcast();

  // final StreamController<String?> selectNotificationSubject =
  //     StreamController<String?>.broadcast();

  // String? selectedNotificationPayload;

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
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

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

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
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
