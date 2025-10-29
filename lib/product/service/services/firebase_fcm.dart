import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_start/main.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const lastMessageData = 'last_message_data';
  static const lastMessageTitle = 'last_message_title';
  static const lastMessageBody = 'last_message_body';
  static const lastMessageTime = 'last_message_time';
}

/// Top-level ve entry-point olarak işaretlenmeli
/// Bu, arka planda mesaj dinleme
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    final prefs = await SharedPreferences.getInstance();
    final dataStr = message.data.isNotEmpty
        ? message.data.toString()
        : 'No Data';
    final title = message.notification?.title ?? 'No Title';
    final body = message.notification?.body ?? 'No Body';
    final time = DateTime.now().toIso8601String();

    // Kaydet
    await prefs.setString(PrefKeys.lastMessageData, dataStr);
    await prefs.setString(PrefKeys.lastMessageTitle, title);
    await prefs.setString(PrefKeys.lastMessageBody, body);
    await prefs.setString(PrefKeys.lastMessageTime, time);
  } on Exception catch (e) {
    throw Exception('Error in background message handler: $e');
  }
}

class FirebaseService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Arka planda mesaj dinleme
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Token alma
    await _getToken();

    // Bildirim izni isteme
    await notificationPermission();

    // Ön planda mesaj dinleme
    _listenForegroundMessages();

    // Bildirim etkileşimlerini ayarla
    await _setupInteractedMessage();
  }

  //Bildirim izni isteme
  Future<String> notificationPermission() async {
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
  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('--📲 Ön planda mesaj alındı!');
      debugPrint('--🔹 Veri: ${message.data}');
      debugPrint(
        '--🔹 Bildirim: ${message.notification?.title} - ${message.notification?.body}',
      );
    });
  }

  //uygulama durumuna göre bildirim etkileşimlerini ayarla
  Future<void> _setupInteractedMessage() async {
    // Uygulama kapalıyken bildirime tıklayıp açıldı mı?
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    // Arka plandayken bildirime tıklanırsa
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  // Bildirime tıklanma durumunda hangi sayfaya gidileceği
  void _handleMessage(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    final type = message.data['type'];
    if (type == 'chat') {
      context.goNamed('Screen1');
    } else if (type == 'order') {
      context.goNamed('Screen2');
    }
  }

  //firebasten device özelinde mesaj gönderebilmek için tokeni aldık
  //alınan cihaza özgüdür
  Future<void> _getToken() async {
    final token = await _messaging.getToken();
    if (token != null) {
      debugPrint('--🔑 FCM Token: $token');
    } else {
      debugPrint('--❌ FCM Token alınamadı');
    }
  }
}
