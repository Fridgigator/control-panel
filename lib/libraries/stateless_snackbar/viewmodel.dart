import 'dart:developer';

import 'package:control_panel/libraries/get_updates.dart';
import 'package:flutter/foundation.dart';

class StatelessSnackbarViewModel with ChangeNotifier {
  bool disposed = false;
  StatelessSnackbarViewModel() {
    disposed = false;
    () async {
      log("Awaiting for Message");
      await for (Error m in errorsController.stream) {
        if (disposed != false) {
          break;
        }
        log("Message: $m");
        switch (m) {
          case Error.initError:
            text = "Cannot initialize";
            break;
          case Error.disconnected:
            text = "Disconnected";
            break;
          case Error.removeError:
            text = null;
            break;
        }
      }
    }();
  }
  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  String? _text;
  bool get visible => _text != null;
  String? get text => _text;
  set text(String? error) {
    _text = error;
    notifyListeners();
  }
}
