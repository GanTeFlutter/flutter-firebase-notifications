<h1 align="center">🔥 Firebase Cloud Messaging (FCM) Functions</h1>
<p align="center">
  Flutter uygulamalarında <b>Firebase Cloud Messaging (FCM)</b> entegrasyonu için kullanılan yardımcı fonksiyonları içerir.
</p>
<hr>
<h3>📦 Fonksiyonlar</h3>
<ul>
  <li><b>🔧 initializeFCM()</b> – FCM başlatma işlemlerini yapar.</li>
  <li><b>🔔 requestNotificationPermission()</b> – Kullanıcıdan bildirim izni ister.</li>
  <li><b>🎧 listenForegroundMessages()</b> – Uygulama ön plandayken gelen mesajları dinler.</li>
  <li><b>🔙 handleMessageOpenedApp()</b> – Arka planda bildirime tıklanma durumunu yakalar.</li>
  <li><b>🔑 fetchDeviceToken()</b> – Cihaza özel FCM tokenini alır.</li>
</ul>
<hr>
<h3>📩 Arka Plan Mesaj İşleyici</h3>
<h4><code>@pragma('vm:entry-point')</code> <code>_firebaseMessagingBackgroundHandler(RemoteMessage message)</code></h4>
<p>
  Bu fonksiyon, uygulama <b>arka planda</b> veya <b>tamamen kapalıyken (terminated)</b> gelen mesajları yakalamak için kullanılır.  
  Firebase Cloud Messaging (FCM) bu fonksiyonu otomatik olarak çağırır.  
  <code>@pragma('vm:entry-point')</code> etiketi, Flutter derleyicisinin bu fonksiyonu optimize ederken
  <i>silmemesi</i> için gereklidir.
</p>
<ul>
  <li>📨 Sessiz bildirimleri (background data mesajlarını) işler.</li>
  <li>⚙️ Diğer Firebase servisleri kullanılacaksa, önce <code>Firebase.initializeApp()</code> çağrısı yapılmalıdır.</li>
  <li>🧠 Uygulama kapalı olsa bile veri kaydı, loglama veya senkronizasyon gibi işlemler yapılabilir.</li>
</ul>
<pre><code class="language-dart">
@pragma('vm:entry-point')
Future&lt;void&gt; _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Eğer arka planda Firestore veya diğer Firebase servislerini kullanacaksanız
  // önce initializeApp çağrısı yapılmalıdır.
  await Firebase.initializeApp();
  debugPrint('Handling a background message: ${message.messageId}');
}
</code></pre>
<pre><code class="language-dart">
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
</code></pre>
<h3>📚 Referanslar</h3>
<ul>
  <li><a href="https://firebase.google.com/codelabs/firebase-fcm-flutter?hl=tr" target="_blank">
    🔗 Firebase FCM Flutter Codelab</a></li>
  <li><a href="https://firebase.google.com/docs/cloud-messaging/flutter/client" target="_blank">
    🔗 Firebase Cloud Messaging Dokümantasyonu</a></li>
  <li><a href="https://akillisletme.com/#/fcm-diagram" target="_blank">
    🔗 FCM Akış Diyagramı</a></li>
</ul>
