import 'dart:developer';

import 'package:flutter/foundation.dart';

class StatelessSnackbarViewModel with ChangeNotifier {
  static StatelessSnackbarViewModel _instance =
      StatelessSnackbarViewModel._internal();

  String? _text;
  StatelessSnackbarViewModel._internal();
  factory StatelessSnackbarViewModel() {
    return _instance;
  }

  bool get visible => _instance._text != null;
  String? get text => _instance._text;

  @override
  dispose() {
    _instance = StatelessSnackbarViewModel._internal();
    super.dispose();
  }

  set text(String? error) {
    log("Setting $error");
    _instance._text = error;
    notifyListeners();
  }
}
