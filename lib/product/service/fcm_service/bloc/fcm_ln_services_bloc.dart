import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_start/product/service/fcm_service/firebase_fcm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fcm_ln_services_event.dart';
part 'fcm_ln_services_state.dart';

class FcmLnServicesBloc extends Bloc<FcmLnServicesEvent, FcmLnServicesState> {
  FcmLnServicesBloc(this._firebaseService) : super(FcmLnServicesInitial()) {
    on<FcmLnServicesInitialEvent>(_onInitialize);
    on<FcmLnServicesMessageReceivedEvent>(_onMessageReceived);

    // BLoC oluşturulduğunda otomatik başlat
    _initializeFcm();
  }

  final FirebaseService _firebaseService;
  StreamSubscription<RemoteMessage>? _messageSubscription;

  void _initializeFcm() {
    // Stream'i dinlemeye başla
    _messageSubscription = _firebaseService.listenForegroundMessages2.listen(
      (RemoteMessage message) {
        // Yeni mesaj geldiğinde event ekle
        add(FcmLnServicesMessageReceivedEvent(message));
      },
    );
  }

  Future<void> _onInitialize(
    FcmLnServicesInitialEvent event,
    Emitter<FcmLnServicesState> emit,
  ) async {
    // İhtiyaç duyulursa başka initialization işlemleri
  }

  void _onMessageReceived(
    FcmLnServicesMessageReceivedEvent event,
    Emitter<FcmLnServicesState> emit,
  ) {
    final message = event.message;

    debugPrint('--📲 Ön planda mesaj alındı!');
    debugPrint('--🔹 Veri: ${message.data}');
    debugPrint(
      '--🔹 Bildirim: ${message.notification?.title} - ${message.notification?.body}',
    );

    emit(FcmLnServicesMessageReceived(message));
  }

  @override
  Future<void> close() {
    // BLoC dispose edildiğinde stream'i kapat
    _messageSubscription?.cancel();
    return super.close();
  }
}
