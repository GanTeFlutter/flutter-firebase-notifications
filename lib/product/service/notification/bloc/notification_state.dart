// notification_state.dart
part of 'notification_bloc.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationListening extends NotificationState {}

// class NotificationReceived extends NotificationState {
//   NotificationReceived(this.message);
//   final RemoteMessage message;
// }

class SendMessageState extends NotificationState {
  SendMessageState(this.message);
  final String message;
}
