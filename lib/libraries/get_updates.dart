import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:control_panel/constants.dart';
import 'package:control_panel/data_structures/data_value.dart';
import 'package:control_panel/data_structures/fridge.dart';
import 'package:control_panel/data_structures/hubs.dart';
import 'package:control_panel/data_structures/sensor.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

HubMessage? cachedHubMessage;
FridgeMessage? cachedFridgeMessage;

StreamController<Error> errorsController = StreamController<Error>.broadcast();
StreamController<Message> messagesController =
    StreamController<Message>.broadcast();

Stream<Error> errors = errorsController.stream;
Stream<Message> messages = messagesController.stream;
StreamController<Message> messagesSend = StreamController<Message>.broadcast();
void getUpdates() async {
  bool error = false;
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
      errorsController.sink.add(Error.initError);
    }

    canDoBackground = await FlutterBackground.enableBackgroundExecution();
    if (!canDoBackground) {
      error = true;
      errorsController.sink.add(Error.initError);
    }
  } catch (e) {
    if (e is! MissingPluginException) {
      error = true;
      log("$e");
      errorsController.sink.add(Error.initError);
    }
  }
  if (error == false) {
    _getData();
  }
}

void _getData() async {
  log("get data");
  WebSocketChannel? globalChannel;
  while (true) {
    log("starting get data");
    WidgetsFlutterBinding.ensureInitialized();
    try {
      try {
        (await SharedPreferences.getInstance()).getString("accessToken");
        (await SharedPreferences.getInstance()).getString("darktheme");
      } catch (e) {
        // Wrong type, lets delete it
        (await SharedPreferences.getInstance()).remove("darktheme");
        (await SharedPreferences.getInstance()).remove("accessToken");
      }
      String? accessToken =
          (await SharedPreferences.getInstance()).getString("accessToken");
      if (accessToken == null || accessToken == "") {
        log("no access token");
        await Future.delayed(const Duration(seconds: 1));
        continue;
      } else {
        var channel = WebSocketChannel.connect(Uri.parse(
            '$remoteWsDomain/api/frontend/v2/get-overview?accessToken=$accessToken'));
        if (channel is WebSocketChannelException) {
          log("Error in socket");
          throw "error in socket";
        }
        globalChannel = channel;
        log("Listening");
        if (!messagesSend.isClosed) {
          messagesSend.stream.listen((event) {
            if (event is UpdateMessage) {
              log("Awaiting for Message: Sending data");
              channel.sink.add('{"command":"read-all"}');
            }
          });
        } else {
          print("Can't listen to message stream");
        }
        await for (String data in channel.stream) {
          log("In stream");
          String? tmpAccessToken =
              (await SharedPreferences.getInstance()).getString("accessToken");
          if (tmpAccessToken != accessToken) {
            throw _AccessTokenChanged();
          }
          log("Removed text");
          errorsController.add(Error.removeError);
          log("data=$data");
          var map = jsonDecode(data);
          if (map["type"] == "hub") {
            List<dynamic> hubDynamic = map["hub"];
            List<Hub> obtainedHubs = hubDynamic.map((e) {
              log("pings-type: ${e["pings"].runtimeType}");
              List<DateTime> pings = [];
              if (e["pings"] is! String && e["pings"].isNotEmpty) {
                log("pings-type: ${e["pings"].runtimeType}");

                pings = (e["pings"] as List).map((e) {
                  return (DateTime.fromMillisecondsSinceEpoch((e as int) * 1000)
                      .add(DateTime.now().timeZoneOffset));
                }).toList();
              }
              log("type=: ${e["pings"].runtimeType} ${e["name"].runtimeType}, ${e["last-ping"].runtimeType}, ${pings.runtimeType}");
              DateTime lastSeen = DateTime.fromMillisecondsSinceEpoch(
                      (e["last-ping"] as int) * 1000)
                  .add(DateTime.now().timeZoneOffset);
              String name = e["name"];
              Hub h = Hub(id: name, lastSeen: lastSeen, pings: pings);
              return h;
            }).toList();
            cachedHubMessage = HubMessage(obtainedHubs);
            messagesController.add(HubMessage(obtainedHubs));
            log("setting lastPing = added to message");
          }
          if (map["type"] == "fridges") {
            log("fridges=${map["fridges"]}");
            List<dynamic> m = map["fridges"];

            List<Fridge> newFridges = m.map((fridgeRec) {
              List<Sensor> sensors =
                  (fridgeRec['sensors'] as List).map((sensorDynamic) {
                String modelString = sensorDynamic['model'];
                ModelType model;
                switch (modelString) {
                  case "0":
                    model = ModelType.lpstk;
                    break;
                  case "1":
                    model = ModelType.thingy;
                    break;
                  case "2":
                    model = ModelType.pico;
                    break;
                  default:
                    throw "Wrong model number";
                }
                String location = sensorDynamic['location'];
                String name = sensorDynamic['name'];
                List<DataValue> dataValues =
                    (sensorDynamic['data-values'] as List).map((v) {
                  if (v['value'].runtimeType != int) {
                    debugPrint("v=${v['value']}; v=${v['value'].runtimeType}");
                  }
                  double value = v['value'].toDouble();
                  int typeOfDataInt = v['type-of-data'];
                  TypeOfData typeOfData;
                  switch (typeOfDataInt) {
                    case 1:
                      typeOfData = TypeOfData.temp;
                      break;
                    case 2:
                      typeOfData = TypeOfData.humidity;
                      break;
                    case 3:
                      typeOfData = TypeOfData.dht22Temp;
                      break;
                    case 4:
                      typeOfData = TypeOfData.dht22Humidity;
                      break;
                    case 5:
                      typeOfData = TypeOfData.dht11Temp;
                      break;
                    case 6:
                      typeOfData = TypeOfData.dht11Humidity;
                      break;
                    case 7:
                      typeOfData = TypeOfData.picoTemp;
                      break;
                    default:
                      throw 'Incorrect type of data';
                  }
                  return DataValue(
                      value: value,
                      typeOfData: typeOfData,
                      time: DateTime.fromMillisecondsSinceEpoch(
                          v['time'] * 1000));
                }).toList();
                dataValues.sort(
                    (DataValue a, DataValue b) => a.time.compareTo(b.time));
                return Sensor(
                    model: model,
                    location: location,
                    name: name,
                    dataValues: dataValues);
              }).toList();
              double medianTemp = fridgeRec["median-temp"].toDouble();
              Fridge f = Fridge(
                medianTemp: medianTemp,
                sensors: sensors,
                lowTemp: fridgeRec["low-temp"].toDouble(),
                highTemp: fridgeRec["high-temp"].toDouble(),
                lowHumidity: fridgeRec["low-humidity"].toDouble(),
                highHumidity: fridgeRec["high-humidity"].toDouble(),
                name: fridgeRec["name"],
                id: fridgeRec["id"],
              );
              return f;
            }).toList();
            cachedFridgeMessage = FridgeMessage(newFridges);
            messagesController.add(FridgeMessage(newFridges));
          }
        }
        log("finished for");
        errorsController.sink.add(Error.disconnected);
      }
    } catch (e, stacktrace) {
      debugPrint("caught $e");
      debugPrint("$stacktrace");
      if (e is! _AccessTokenChanged) {
        debugPrint("on exception: $e, $stacktrace");
        errorsController.sink.add(Error.disconnected);
      }
    } finally {
      log("canceling");
      globalChannel?.sink.close(4000, "");
    }
    log("waiting");

    await Future.delayed(const Duration(seconds: 10));
    log("finished waiting");
  }
}

enum Error { initError, disconnected, removeError }

abstract class Message {
  const Message();
}

class HubMessage extends Message {
  final List<Hub> h;

  HubMessage(this.h);
}

class FridgeMessage extends Message {
  final List<Fridge> h;

  FridgeMessage(this.h);
}

class UpdateMessage extends Message {
  const UpdateMessage();
}

class _AccessTokenChanged {}
