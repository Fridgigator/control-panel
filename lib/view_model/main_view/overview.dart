import 'dart:async';
import 'dart:developer';

import 'package:control_panel/data_structures/fridge.dart';
import 'package:control_panel/data_structures/hubs.dart';
import 'package:control_panel/libraries/get_updates.dart';
import 'package:flutter/material.dart';

bool _finishedLoading = false;

class OverviewViewModel with ChangeNotifier {
  DateTime _lastPing = DateTime.fromMicrosecondsSinceEpoch(0);
  bool _hasPinged = false;
  int _amountUp = 0;
  int _amountDown = 0;
  bool? _disposed;

  bool get finishedLoading => _finishedLoading;
  bool get hasPinged => _hasPinged;
  DateTime get lastPinged => _lastPing;
  int get amountUp => _amountUp;
  int get amountDown => _amountDown;

  set finishedLoading(bool finishedLoading) {
    log("Awaiting for Message: _disposed = $_disposed; set finishedLoading to: $finishedLoading");
    _finishedLoading = finishedLoading;
    if (_disposed != true) {
      notifyListeners();
    }
  }

  set hasPinged(bool hasPinged) {
    if (hasPinged != _hasPinged) {
      _hasPinged = hasPinged;
      if (_disposed != true) {
        notifyListeners();
      }
    }
  }

  set lastPinged(DateTime lastPing) {
    _lastPing = lastPing;
    var curTime = DateTime.now();
    bool oldHasPinged = hasPinged;
    if (curTime.difference(_lastPing) < const Duration(seconds: 5)) {
      hasPinged = true;
    } else {
      hasPinged = false;
    }
    if (_disposed != true && oldHasPinged != hasPinged) {
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
    if (_disposed != true && oldAmountUp != _amountUp) {
      notifyListeners();
    }
  }

  set amountDown(int amountDown) {
    log("amntDown=$amountDown");
    _amountDown = amountDown;
    if (_disposed != true) {
      notifyListeners();
    }
  }

  Timer? _timer;
  List<Hub> _hubs = [];

  set hubs(List<Hub> h) {
    if (_disposed != true) {
      _hubs = h;
      var curTime = DateTime.now();
      int localAmountUp = 0;
      int localAmountDown = 0;
      for (Hub h in _hubs) {
        log("pinged: $curTime $_lastPing");
        if (curTime.difference(h.lastSeen) < const Duration(seconds: 5)) {
          localAmountUp++;
        } else {
          localAmountDown++;
        }
      }
      amountDown = localAmountDown;
      amountUp = localAmountUp;
    } else {
      log("Awaiting for Message: disposed");
    }
  }

  List<Fridge> _fridges = [];
  List<Fridge> get fridges => _fridges;
  set fridges(List<Fridge> f) {
    _fridges = f;
    notifyListeners();
  }

  bool error = false;

  OverviewViewModel() {
    log("Awaiting for Message: Started");
    _finishedLoading = false;
    _disposed = false;
    _timer = Timer.periodic(const Duration(seconds: 5), (t) {
      var curTime = DateTime.now();
      int localAmountUp = 0;
      int localAmountDown = 0;
      DateTime tmpLastPing = DateTime.fromMicrosecondsSinceEpoch(0);
      for (Hub h in _hubs) {
        if (tmpLastPing.isBefore(h.lastSeen)) {
          tmpLastPing = h.lastSeen;
        }
        if (curTime.difference(h.lastSeen) < const Duration(seconds: 5)) {
          localAmountUp++;
        } else {
          localAmountDown++;
        }
      }
      lastPinged = tmpLastPing;
      amountDown = localAmountDown;
      amountUp = localAmountUp;

      log("pinged: $hasPinged");
    });
    () async {
      log("Awaiting for Message: $cachedHubMessage, $cachedFridgeMessage");
      messagesSend.add(const UpdateMessage());
      await for (Message m in messagesController.stream) {
        log("Awaiting for Message: got message, _disposed=$_disposed");
        finishedLoading = true;
        if (_disposed != false) {
          break;
        }
        log("Awaiting for Message: $m");
        if (m is HubMessage) {
          hubs = m.h;
          log("Awaiting for Message: is hub message: ${m.h}, finishedLoading=$finishedLoading");
        } else if (m is FridgeMessage) {
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
    _disposed = true;
    _timer?.cancel();
    super.dispose();
  }
}