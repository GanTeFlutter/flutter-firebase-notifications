import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_start/product/service/service_locator.dart';

@immutable
final class AppInitialize {
  Future<void> make() async {
    await runZonedGuarded(_initialize, (error, stack) {
      locator.logger.e('AppInitialize error: $error ');
    });
  }

  Future<void> _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    setupLocator();
  }
}
