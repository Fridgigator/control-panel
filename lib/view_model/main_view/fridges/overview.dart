import 'dart:async';

import 'package:control_panel/data_structures/data_value.dart';
import 'package:control_panel/data_structures/fridge.dart';
import 'package:control_panel/data_structures/sensor.dart';
import 'package:control_panel/libraries/get_updates.dart';
import 'package:flutter/material.dart';

bool _finishedLoading = false;

class FridgeViewModel with ChangeNotifier {
  List<Fridge> _fridges = [];
  DateTime _currentTime = DateTime.fromMicrosecondsSinceEpoch(0);

  bool get finishedLoading => _finishedLoading;
  List<Fridge> get fridges => _fridges;

  set finishedLoading(bool finishedLoading) {
    _finishedLoading = finishedLoading;
    if (disposed != true) {
      notifyListeners();
    }
  }

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
    _finishedLoading = false;

    () async {
      messagesSend.add(const UpdateMessage());
      await for (Message m in messagesController.stream) {
        if (disposed != false) {
          break;
        }
        finishedLoading = true;
        if (m is FridgeMessage) {
          fridges = m.h;
        }
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
