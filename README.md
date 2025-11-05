, Flutter uygulamalarında Firebase Cloud Messaging (FCM) entegrasyonu için kullanılan yardımcı fonksiyonları içerir.


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



Aşşağıdaki linkler referans alaınarak yapıklmıştıur

https://firebase.google.com/codelabs/firebase-fcm-flutter?hl=tr#0

https://firebase.google.com/docs/cloud-messaging/fcm-architecture?hl=tr



fcm adım adım ne yapacağını veya neyi nasıl yapacağınızı gösteren şema 

https://akillisletme.com/#/fcm-diagram


fcm 1.0.7