import 'package:flutter/material.dart';

import 'package:flutter_base_start/product/service/notification/bloc/notification_bloc.dart';
import 'package:flutter_base_start/product/service/notification/helper_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

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
      ],
      child: child,
    );
  }

  /// FCM state değişikliklerini dinle
  /// Ön planda mesaj alındığında yapılacak işlemler burada tanımlanır

  /// Notification state değişikliklerini dinle
  void _onNotificationStateChange(
    BuildContext context,
    NotificationState state,
  ) {
    if (state is SendMessageState) {
      NotificationHelper.showTopSuccessSnackBar(
        state.message,
      );
      Vibration.vibrate();
    }
  }
}
