import 'package:control_panel/views/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) => '';
  }
  //debugPrint = (String? message, {int? wrapWidth}) {};
  runApp(const MyApp());
}
