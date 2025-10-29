import 'package:flutter_base_start/product/service/services/firebase_fcm.dart';
import 'package:flutter_base_start/product/service/services/logger_service.dart';
import 'package:flutter_base_start/product/service/services/shared_preferences_service.dart';

import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  _registerSingletons();
  await _initializeServices();
}

Future<void> _initializeServices() async {
  await locator<SharedPreferencesService>().initialize();
  await locator<FirebaseService>().initialize();
}

void _registerSingletons() {
  locator
    ..registerSingleton<LoggerService>(LoggerService())
    ..registerSingleton<SharedPreferencesService>(SharedPreferencesService())
    ..registerSingleton<FirebaseService>(FirebaseService());
}

extension ServiceLocator on GetIt {
  LoggerService get logger => locator<LoggerService>();

  SharedPreferencesService get sharedprefs =>
      locator<SharedPreferencesService>();

  FirebaseService get firebaseService => locator<FirebaseService>();
}
