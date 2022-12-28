import 'package:control_panel/libraries/get_updates.dart';
import 'package:control_panel/views/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) => '';
  }
  getUpdates();
  runApp(const MyApp());
}
