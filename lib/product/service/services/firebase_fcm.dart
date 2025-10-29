import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_start/main.dart';
import 'package:flutter_base_start/product/service/service_locator.dart';
import 'package:go_router/go_router.dart';

class PrefKeys {
  static const lastMessageData = 'last_message_data';
  static const lastMessageTitle = 'last_message_title';
  static const lastMessageBody = 'last_message_body';
}

/// Top-level ve entry-point olarak işaretlenmeli
/// Bu, arka planda mesaj dinleme
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

   Future<void> initialize() async {
    // Bildirim izni isteme
    await _notificationPermission();
    // Arka planda mesaj dinleme
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // Ön planda mesaj dinleme
    _listenForegroundMessages();

    // Bildirim etkileşimlerini ayarla
    await _setupInteractedMessage();
  }

  //Bildirim izni isteme
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

  //Ön planda mesaj dinlemes
  static void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📲 Ön planda mesaj alındı!');
      debugPrint('🔹 Veri: ${message.data}');
      debugPrint(
        '🔹 Bildirim: ${message.notification?.title} - ${message.notification?.body}',
      );
    });
  }

  //uygulama durumuna göre bildirim etkileşimlerini ayarla
  static Future<void> _setupInteractedMessage() async {
    // Uygulama kapalıyken bildirime tıklayıp açıldı mı?
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    // Arka plandayken bildirime tıklanırsa
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  // Bildirime tıklanma durumunda hangi sayfaya gidileceği
  static void _handleMessage(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    final type = message.data['type'];
    if (type == 'chat') {
      context.goNamed('Screen1');
    } else if (type == 'order') {
      context.goNamed('Screen2');
    }
  }
}
