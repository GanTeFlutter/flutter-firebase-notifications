// notification_event.dart
part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class StartListeningEvent extends NotificationEvent {}

// class MessageReceivedEvent extends NotificationEvent {
//   MessageReceivedEvent(this.message);
//   final RemoteMessage message;
// }

class SendMessageEvent extends NotificationEvent {
  SendMessageEvent(this.message);
  final String message;
}
