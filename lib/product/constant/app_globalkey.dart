import 'package:flutter/material.dart';

@immutable
final class AppKeys {
  const AppKeys._();
  // Navigation
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  // Form Keys
  static final loginFormKey = GlobalKey<FormState>();

  // Helper methods
  static BuildContext? get context => navigatorKey.currentContext;

  static NavigatorState? get navigator => navigatorKey.currentState;

  static OverlayState? get overlay => navigatorKey.currentState?.overlay;

  static void showSnackBar(String message) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
