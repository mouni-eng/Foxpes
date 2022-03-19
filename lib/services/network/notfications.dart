import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:movies_app/main.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/views/client_views/messages_view.dart';
import 'package:movies_app/views/client_views/profile_view.dart';

class NotificationCenter {
  static final _notifications = FlutterLocalNotificationsPlugin();

  Future initNotification() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _notifications.initialize(initializationSettings,
        onSelectNotification: onSelectionMethod);
  }

  void onSelectionMethod(String? payload) {
    print(payload);
    ClientCubit.get(Foxpes.navigatorKey.currentContext).changeBottomNav(1);
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "Foxpes",
        "FoxpesChannel",
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    required String title,
    required String body,
  }) async {
    _notifications.show(0, title, body, await _notificationDetails());
  }
}
