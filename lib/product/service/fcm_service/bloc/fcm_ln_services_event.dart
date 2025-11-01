// fcm_ln_services_event.dart
part of 'fcm_ln_services_bloc.dart';

abstract class FcmLnServicesEvent {}

class FcmLnServicesInitialEvent extends FcmLnServicesEvent {}

class FcmLnServicesMessageReceivedEvent extends FcmLnServicesEvent {
  FcmLnServicesMessageReceivedEvent(this.message);
  final RemoteMessage message;
}
