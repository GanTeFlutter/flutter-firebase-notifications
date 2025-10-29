part of 'version_control_cubit.dart';

@immutable
sealed class VersionControlState {}

final class VersionControlInitial extends VersionControlState {}

final class VersionControlLoading extends VersionControlState {}

final class VersionControlLoaded extends VersionControlState {
  VersionControlLoaded(this.version);
  final String version;
}

final class VersionControlError extends VersionControlState {
  VersionControlError(this.message);
  final String message;
}
