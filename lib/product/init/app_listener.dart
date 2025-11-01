import 'package:flutter/material.dart';
import 'package:flutter_base_start/product/service/fcm_service/bloc/fcm_ln_services_bloc.dart';
import 'package:flutter_base_start/product/service/notification/bloc/notification_bloc.dart';
import 'package:flutter_base_start/product/service/notification/helper_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Tüm uygulama seviyesindeki bloc listener'ları burada toplanır
/// Home ve diğer tüm sayfalar bu wrapper'ın child'ı olarak verilir
class AppListenerWrapper extends StatelessWidget {
  const AppListenerWrapper({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // 1️⃣ Notification Listener
        BlocListener<NotificationBloc, NotificationState>(
          listener: _onNotificationStateChange,
        ),

        // 2️⃣ FCM Listener
        BlocListener<FcmLnServicesBloc, FcmLnServicesState>(
          listener: _onFcmStateChange,
        ),
      ],
      child: child,
    );
  }

  /// FCM state değişikliklerini dinle
  /// Ön planda mesaj alındığında yapılacak işlemler burada tanımlanır

  void _onFcmStateChange(
    BuildContext context,
    FcmLnServicesState state,
  ) {
    if (state is FcmLnServicesMessageReceived) {
      final message = state.message;

      debugPrint('--📲 Ön planda mesaj alındı!');
      debugPrint('--🔹 Veri: ${message.data}');
      debugPrint(
        '--🔹 Bildirim: ${message.notification?.title} - ${message.notification?.body}',
      );

      NotificationHelper.showTopInfoSnackBar(
        'Yeni bildirim: ${message.notification?.title ?? 'Başlık yok'}',
      );
    }
  }

  /// Notification state değişikliklerini dinle
  void _onNotificationStateChange(
    BuildContext context,
    NotificationState state,
  ) {
    if (state is SendMessageState) {
      NotificationHelper.showTopSuccessSnackBar(
        state.message,
      );
    }
  }
}
