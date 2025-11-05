import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_start/product/constant/app_globalkey.dart';
// ignore: library_prefixes

import 'package:flutter_base_start/product/service/service_locator.dart';
import 'package:go_router/go_router.dart';

mixin FirebaseCloudMessageFunctions {
  /// 🔧 FCM başlatma
  Future<void> initializeFCM();

  /// 🔔 Bildirim izni isteme
  Future<String> requestNotificationPermission();

  /// 🎧 Ön planda gelen mesajları dinleme
  Future<void> listenForegroundMessages();

  /// 🔙 Arka planda bildirime tıklanma durumunu işleme
  Future<void> handleMessageOpenedApp();

  /// 🔑 Cihaz tokenini alma
  Future<String> fetchDeviceToken();
}

class FirebaseService with FirebaseCloudMessageFunctions {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// 🔧 FCM başlatma
  @override
  Future<void> initializeFCM() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await handleMessageOpenedApp();
    await requestNotificationPermission();
    await fetchDeviceToken();
    await listenForegroundMessages();
  }

  /// 🔔 Bildirim izni isteme
  @override
  Future<String> requestNotificationPermission() async {
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

  /// 🎧 Ön planda gelen mesajları dinleme
  @override
  Future<void> listenForegroundMessages() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 Foreground mesaj alındı: ${message.notification?.title}');

      // Mesaj verisini kaydet
      locator.sharedprefs.setString(
        'last_message_data',
        jsonEncode(message.data),
      );

      // Bildirim başlık ve gövdesini al
      final title = message.notification?.title ?? 'Yeni Bildirim';
      final body = message.notification?.body ?? 'İçerik yok';

      // UI üzerinde göster (örnek: SnackBar)
    });
  }

  /// 🔙 Arka planda bildirime tıklanma durumunu işleme
  @override
  Future<void> handleMessageOpenedApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('🔔 Bildirime tıklandı: ${message.data}');

      locator.sharedprefs.setString(
        'last_message_data',
        jsonEncode(message.data),
      );

      final navigateHome = message.data['messageData'];
      if (navigateHome != null) {
        locator.sharedprefs.setString(
          'last_navigate_home',
          navigateHome.toString(),
        );
        debugPrint('➡️ Saved navigateHome: $navigateHome');
      }

      final ctx = AppKeys.navigatorKey.currentContext;
      if (ctx != null && ctx.mounted && navigateHome != null) {
        debugPrint('➡️ Navigating to: $navigateHome');
        ctx.goNamed('$navigateHome');
      }
    });
  }

  /// 🔑 Cihaz tokenini alma
  @override
  Future<String> fetchDeviceToken() async {
    final token = await _messaging.getToken();
    if (token != null) {
      debugPrint('** FCM Token: $token');
      return token;
    } else {
      return 'Token alınamadı';
    }
  }
}

/// 📦 Arka planda gelen mesajı işleme
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('📨 Arka planda mesaj alındı: ${message.data}');
}
