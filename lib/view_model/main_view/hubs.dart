import 'dart:async';

import 'package:control_panel/data_structures/fridge.dart';
import 'package:control_panel/data_structures/hubs.dart';
import 'package:control_panel/libraries/get_updates.dart';
import 'package:flutter/material.dart';

bool _finishedLoading = false;

class HubsViewModel with ChangeNotifier {
  DateTime _lastPing = DateTime.fromMicrosecondsSinceEpoch(0);
  bool _hasPinged = false;
  int _amountUp = 0;
  int _amountDown = 0;

  bool get finishedLoading => _finishedLoading;
  bool get hasPinged => _hasPinged;
  DateTime get lastPinged => _lastPing;
  int get amountUp => _amountUp;
  int get amountDown => _amountDown;

  set finishedLoading(bool finishedLoading) {
    _finishedLoading = finishedLoading;
    if (disposed != true) {
      notifyListeners();
    }
  }

  set hasPinged(bool hasPinged) {
    if (hasPinged != _hasPinged) {
      _hasPinged = hasPinged;
      if (disposed != true) {
        notifyListeners();
      }
    }
  }

  set lastPinged(DateTime lastPing) {
    _lastPing = lastPing;
    var curTime = DateTime.now();
    bool oldHasPinged = hasPinged;
    debugPrint("curTime=$curTime - $_lastPing");
    if (curTime.difference(_lastPing) < const Duration(seconds: 6)) {
      hasPinged = true;
    } else {
      hasPinged = false;
    }
    if (disposed != true && oldHasPinged != hasPinged) {
      notifyListeners();
    }
  }

  set amountUp(int amountUp) {
    int oldAmountUp = _amountUp;
    _amountUp = amountUp;
    if (amountUp != 0) {
      hasPinged = true;
    }
    if (amountUp == 0) {
      hasPinged = false;
    }
    if (disposed != true && oldAmountUp != _amountUp) {
      notifyListeners();
    }
  }

  set amountDown(int amountDown) {
    _amountDown = amountDown;
    if (disposed != true) {
      notifyListeners();
    }
  }

  Timer? _timer;
  List<Hub> _hubs = [];
  List<Hub> get hubs => _hubs;
  set hubs(List<Hub> h) {
    if (disposed != true) {
      _hubs = h;
      var curTime = DateTime.now();
      int localAmountUp = 0;
      int localAmountDown = 0;
      for (Hub h in _hubs) {
        if (curTime.difference(h.lastSeen) < const Duration(seconds: 5)) {
          localAmountUp++;
        } else {
          localAmountDown++;
        }
      }
      _hubs.sort((Hub a, Hub b) => a.id.compareTo(b.id));
      amountDown = localAmountDown;
      amountUp = localAmountUp;
    }
  }

  List<Fridge> _fridges = [];
  List<Fridge> get fridges => _fridges;
  set fridges(List<Fridge> f) {
    _fridges = f;
    notifyListeners();
  }

  bool error = false;
  bool disposed = false;

  HubsViewModel() {
    _finishedLoading = false;
    _timer = Timer.periodic(const Duration(seconds: 5), (t) {
      var curTime = DateTime.now();
      int localAmountUp = 0;
      int localAmountDown = 0;
      DateTime tmpLastPing = DateTime.fromMicrosecondsSinceEpoch(0);

      for (Hub h in _hubs) {
        if (tmpLastPing.isBefore(h.lastSeen)) {
          tmpLastPing = h.lastSeen;
        }
        debugPrint("curTime=$curTime - $tmpLastPing");

        if (curTime.difference(h.lastSeen) < const Duration(seconds: 5)) {
          localAmountUp++;
        } else {
          localAmountDown++;
        }
      }
      lastPinged = tmpLastPing;
      amountDown = localAmountDown;
      amountUp = localAmountUp;
    });
    () async {
      messagesSend.add(const UpdateMessage());
      await for (Message m in messagesController.stream) {
        if (disposed != false) {
          break;
        }
        finishedLoading = true;
        if (m is HubMessage) {
          hubs = m.h;
        } else if (m is FridgeMessage) {
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
