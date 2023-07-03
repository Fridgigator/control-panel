import 'dart:async';

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
  int _radarAngle = 0;
  Map<int, List<String>> _radarPoints = {};

  bool get finishedLoading => _finishedLoading;
  bool get hasPinged => _hasPinged;
  DateTime get lastPinged => _lastPing;
  int get amountUp => _amountUp;
  int get amountDown => _amountDown;

  /// The current angle of the sweeper in degrees
  int get radarAngle => _radarAngle;
  set radarAngle(int radarAngle) {
    _radarAngle = radarAngle;
    notifyListeners();
  }

  /// A map of points that should be displayed. The key is the degree where they lie and
  /// the value is a list of hub IDs that will be displayed on hover.
  Map<int, List<String>> get radarPoints => _radarPoints;

  set points(Map<int, List<String>> points) {
    _radarPoints = points;
    notifyListeners();
  }

  set finishedLoading(bool finishedLoading) {
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
        if (curTime.difference(h.lastSeen) < const Duration(seconds: 5)) {
          localAmountUp++;
        } else {
          localAmountDown++;
        }
      }
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

  OverviewViewModel() {
    _finishedLoading = false;
    _disposed = false;

    // Since the hub pings every 2 seconds, we need to sweep 360* every 2 seconds,
    // and our angular velocity is 180*/second, or one degree every 6 milliseconds.
    _timer = Timer.periodic(const Duration(milliseconds: 6), (t) {
      // At 359, we roll over back to 0
      if (radarAngle == 359) {
        radarAngle = 0;
      } else {
        radarAngle++;
      }
      var curTime = DateTime.now();
      int localAmountUp = 0;
      int localAmountDown = 0;
      DateTime tmpLastPing = DateTime.fromMicrosecondsSinceEpoch(0);
      var points = radarPoints;
      points.remove(radarAngle);
      for (Hub h in _hubs) {
        if (tmpLastPing.isBefore(h.lastSeen)) {
          tmpLastPing = h.lastSeen;
//          points.remove(radarAngle/.);
        }
        if (curTime.difference(h.lastSeen) < const Duration(seconds: 10)) {
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
        finishedLoading = true;
        if (_disposed != false) {
          break;
        }
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
    _disposed = true;
    _timer?.cancel();
    super.dispose();
  }
}
