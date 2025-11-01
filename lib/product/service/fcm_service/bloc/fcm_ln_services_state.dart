part of 'fcm_ln_services_bloc.dart';

@immutable
sealed class FcmLnServicesState {}

final class FcmLnServicesInitial extends FcmLnServicesState {}

final class FcmLnServicesMessageReceived extends FcmLnServicesState {
  FcmLnServicesMessageReceived(this.message);

  final RemoteMessage message;
}
