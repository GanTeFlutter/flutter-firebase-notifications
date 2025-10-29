import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_start/firebase_options.dart';
import 'package:flutter_base_start/product/service/service_locator.dart';


@immutable
final class AppInitialize {
  Future<void> make() async {
    WidgetsFlutterBinding.ensureInitialized();

    await runZonedGuarded(_initialize, (error, stack) {
      locator.logger.e('AppInitialize error: $error ');
    });
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await setupLocator();
    
  }
}
