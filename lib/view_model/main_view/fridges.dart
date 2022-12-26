import 'dart:async';
import 'dart:developer';

import 'package:control_panel/data_structures/fridge.dart';
import 'package:control_panel/libraries/get_updates.dart';
import 'package:flutter/material.dart';

class FridgeViewModel with ChangeNotifier {
  List<Fridge> _fridges = [];
  DateTime _currentTime = DateTime.fromMicrosecondsSinceEpoch(0);

  List<Fridge> get fridges => _fridges;
  set fridges(List<Fridge> fridges) {
    _fridges = fridges;
    notifyListeners();
  }

  DateTime get currentTime => _currentTime;
  set currentTime(DateTime currentTime) {
    _currentTime = currentTime;
    notifyListeners();
  }

  Timer? _timer;
  bool disposed = false;
  FridgeViewModel() {
    _timer = Timer.periodic(const Duration(seconds: 5), (t) {
      currentTime = DateTime.now();
    });
    () async {
      log("Awaiting for Message");
      await for (Message m in messagesController.stream) {
        if (disposed != false) {
          break;
        }
        log("Message: $m");
        if (m is FridgeMessage) {
          fridges = m.h;
        }
      }
    }();
    () async {
      log("Awaiting for Error Message");
      await for (Error m in errorsController.stream) {
        log("Error Message: ${m.name}");
      }
    }();
  }

  @override
  void dispose() {
    disposed = true;
    _timer?.cancel();
    super.dispose();
  }
}
