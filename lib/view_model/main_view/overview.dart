import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:control_panel/constants.dart';
import 'package:control_panel/data_structures/fridge.dart';
import 'package:control_panel/libraries/stateless_snackbar/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OverviewViewModel with ChangeNotifier {
  DateTime _lastPing = DateTime.fromMicrosecondsSinceEpoch(0);
  bool _hasPinged = false;
  int _amountUp = 0;
  int _amountDown = 0;

  bool get hasPinged => _hasPinged;
  DateTime get lastPinged => _lastPing;
  int get amountUp => _amountUp;
  int get amountDown => _amountDown;

  set hasPinged(bool hasPinged) {
    if (hasPinged != _hasPinged) {
      _hasPinged = hasPinged;
      notifyListeners();
    }
  }

  set lastPing(DateTime lastPing) {
    _lastPing = lastPing;
    var curTime = DateTime.now();
    log("pinged: $curTime $_lastPing");
    if (curTime.difference(_lastPing) < const Duration(seconds: 5)) {
      hasPinged = true;
    } else {
      hasPinged = false;
    }

    notifyListeners();
  }

  set amountUp(int amountUp) {
    _amountUp = amountUp;
    notifyListeners();
  }

  set amountDown(int amountDown) {
    log("amntDown=$amountDown");
    _amountDown = amountDown;
    notifyListeners();
  }

  WebSocketChannel? channel;
  Timer? _timer;
  List<Fridge> _fridges = [];
  List<Fridge> get fridges => _fridges;
  set fridges(List<Fridge> f) {
    _fridges = f;
    notifyListeners();
  }

  bool error = false;
  final String accessToken;

  OverviewViewModel({required this.accessToken}) {
    _timer = Timer.periodic(const Duration(seconds: 5), (t) {
      var curTime = DateTime.now();
      log("pinged: $curTime $_lastPing");
      if (curTime.difference(_lastPing) < const Duration(seconds: 5)) {
        hasPinged = true;
      } else {
        hasPinged = false;
      }
      log("pinged: $hasPinged");
    });
    () async {
      const androidConfig = FlutterBackgroundAndroidConfig(
        notificationTitle: "Fridgigator",
        notificationText:
            "Background notification for keeping the app running in the background",
        notificationImportance: AndroidNotificationImportance.Default,
        notificationIcon:
            AndroidResource(name: 'background_icon', defType: 'drawable'),
      );
      try {
        var canDoBackground =
            await FlutterBackground.initialize(androidConfig: androidConfig);
        if (!canDoBackground) {
          error = true;
          StatelessSnackbarModel()
              .setText("Cannot stay alive in the background");
        }

        canDoBackground = await FlutterBackground.enableBackgroundExecution();
        if (!canDoBackground) {
          error = true;
          StatelessSnackbarModel()
              .setText("Cannot stay alive in the background");
        }
      } catch (e) {
        if (e is! MissingPluginException) {
          log("$e");
          error = true;
          StatelessSnackbarModel()
              .setText("Cannot stay alive in the background");
        }
      }
      log("error = $error");
      if (error == false) {
        _getData();
      }
    }();
  }
  void _getData() async {
    log("get data");
    error = false;
    while (true) {
      log("starting get data");

      try {
        var channel = WebSocketChannel.connect(Uri.parse(
            '$remoteWsDomain/api/frontend/v2/get-overview?accessToken=$accessToken'));
        if (channel is WebSocketChannelException) {
          throw "error in socket";
        }
        this.channel = channel;

        log("Listening");

        await for (String data in channel.stream) {
          log("Removed text");
          StatelessSnackbarModel().removeText();

          log("data=$data");
          var map = jsonDecode(data);
          if (map["type"] == "hub") {
            log("setting lastPing");
            List<dynamic> lastPingsDynamic = map["hub"]["last-ping"];
            if (lastPingsDynamic.isEmpty) {
              lastPing = DateTime.fromMillisecondsSinceEpoch(0);
            } else {
              List<int> lastPingsTimestamp =
                  lastPingsDynamic.map((e) => (e as int)).toList();
              List<DateTime> lastPings = lastPingsTimestamp
                  .map((timestamp) =>
                      DateTime.fromMillisecondsSinceEpoch((timestamp) * 1000))
                  .toList();

              lastPing = DateTime.fromMillisecondsSinceEpoch(0);

              lastPing = lastPings.reduce((a, b) {
                if (a.isAfter(b)) {
                  return a;
                } else {
                  return b;
                }
              });
              amountDown = lastPings
                  .where((element) => DateTime.now()
                      .subtract(const Duration(seconds: 5))
                      .isAfter(element))
                  .length;
              amountUp = lastPings
                  .where((element) => DateTime.now()
                      .subtract(const Duration(seconds: 5))
                      .isBefore(element))
                  .length;
              log("lrp: $lastPings $lastPinged $amountUp $amountDown");
            }
          }
          if (map["type"] == "fridges") {
            log("fridges=${map["fridges"]}");
            List<dynamic> m = map["fridges"];

            List<Fridge> newFridges = m.map((fridgeRec) {
              Fridge f = Fridge(
                medianTemp: fridgeRec["median-temp"],
                lowTemp: fridgeRec["low-temp"],
                highTemp: fridgeRec["high-temp"],
                lowHumidity: fridgeRec["low-humidity"],
                highHumidity: fridgeRec["high-humidity"],
                name: fridgeRec["name"],
                id: fridgeRec["id"],
              );
              log("Fridge: $f");
              return f;
            }).toList();
            fridges = newFridges;
          }
        }
        log("finished for");
        StatelessSnackbarModel().setText("Disconnected");
      } catch (e, stacktrace) {
        log("on exception: $e, $stacktrace");
        StatelessSnackbarModel().setText("Disconnected");
      } finally {
        log("canceling");
        channel?.sink.close(4000, "");
      }
      log("waiting");

      await Future.delayed(const Duration(seconds: 10));
      log("finished waiting");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    log("canceling");
    channel?.sink.close(4000, "");
    super.dispose();
  }
}
