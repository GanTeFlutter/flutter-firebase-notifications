import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_start/product/service/service_locator.dart';

class PrefKeys {
  static const lastMessageData = 'last_message_data';
  static const lastMessageTitle = 'last_message_title';
  static const lastMessageBody = 'last_message_body';
}

/// Top-level ve entry-point olarak işaretlenmeli
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //Bu, uygulama arka planda veya kapalıyken gelen mesajın işlenmesini sağlar
  await Firebase.initializeApp();
  await locator.sharedprefs.setString(
    PrefKeys.lastMessageData,
    message.data.toString(),
  );
  await locator.sharedprefs.setString(
    PrefKeys.lastMessageTitle,
    message.notification?.title.toString() ?? 'No Title',
  );
  await locator.sharedprefs.setString(
    PrefKeys.lastMessageBody,
    message.notification?.body.toString() ?? 'No Body',
  );
}

class FirebaseService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await _notificationPermission();
    _listenForegroundMessages();
  }

  static Future<String> _notificationPermission() async {
    final settings = await _messaging.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return 'İzin zaten verilmiş';
    }
    final newSettings = await _messaging.requestPermission();
    if (newSettings.authorizationStatus == AuthorizationStatus.authorized) {
      return 'İzin verildi';
    } else if (newSettings.authorizationStatus == AuthorizationStatus.denied) {
      return 'İzin reddedildi, ayarlara yönlendiriliyor...';
    } else {
      return 'İzin durumu: ${newSettings.authorizationStatus}';
    }
  }

  static void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📲 Ön planda mesaj alındı!');
      debugPrint('🔹 Veri: ${message.data}');
      debugPrint(
        '🔹 Bildirim: ${message.notification?.title} - ${message.notification?.body}',
      );
    });
  }
}
