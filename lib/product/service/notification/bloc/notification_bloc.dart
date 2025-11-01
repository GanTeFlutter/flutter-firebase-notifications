import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

// BLoC
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<SendMessageEvent>(notificationSend);
  }

  void notificationSend(
    SendMessageEvent event,
    Emitter<NotificationState> emit,
  ) {
    debugPrint('--NotificationBloc: Message received: ${event.message}');
    emit(SendMessageState(event.message));
  }
}
