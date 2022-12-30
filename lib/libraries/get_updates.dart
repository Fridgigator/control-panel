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
      debugPrint("$e");
      errorsController.sink.add(Error.initError);
    }
  }
  if (error == false) {
    _getData();
  }
}

void _getData() async {
  bool connected = false;
  WebSocketChannel? globalChannel;
  while (true) {
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
        await Future.delayed(const Duration(seconds: 1));
        continue;
      } else {
        var channel = WebSocketChannel.connect(Uri.parse(
            '$remoteWsDomain/api/frontend/v2/get-overview?accessToken=$accessToken'));
        if (channel is WebSocketChannelException) {
          throw "error in socket";
        }
        connected = true;
        globalChannel = channel;
        if (!messagesSend.isClosed) {
          messagesSend.stream.listen((event) {
            if (event is UpdateMessage) {
              if (!connected) {
                return;
              }
              channel.sink.add('{"command":"read-all"}');
            }
          });
        } else {
          debugPrint("Can't listen to message stream");
        }
        await for (String data in channel.stream) {
          String? tmpAccessToken =
              (await SharedPreferences.getInstance()).getString("accessToken");
          if (tmpAccessToken != accessToken) {
            throw _AccessTokenChanged();
          }
          errorsController.add(Error.removeError);
          var map = jsonDecode(data);
          if (map["type"] == "hub") {
            List<dynamic> hubDynamic = map["hub"];
            List<Hub> obtainedHubs = hubDynamic.map((e) {
              List<DateTime> pings = [];
              if (e["pings"] is! String && e["pings"].isNotEmpty) {
                pings = (e["pings"] as List).map((e) {
                  return (DateTime.fromMillisecondsSinceEpoch(
                      (e as int) * 1000));
                }).toList();
              }
              DateTime lastSeen = DateTime.fromMillisecondsSinceEpoch(
                  (e["last-ping"] as int) * 1000);
              String name = e["name"];
              Hub h = Hub(id: name, lastSeen: lastSeen, pings: pings);
              return h;
            }).toList();
            cachedHubMessage = HubMessage(obtainedHubs);
            messagesController.add(HubMessage(obtainedHubs));
          }
          if (map["type"] == "fridges") {
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
                List<DataValue> dataValues;
                String sensorID = sensorDynamic['uuid'];

                if (sensorDynamic['data-values'] == null) {
                  dataValues = [];
                } else {
                  dataValues = (sensorDynamic['data-values'] as List).map((v) {
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
                    assert(DateTime.fromMillisecondsSinceEpoch(v['time'] * 1000)
                        .isBefore(DateTime.now()));

                    return DataValue(
                        value: value,
                        typeOfData: typeOfData,
                        time: DateTime.fromMillisecondsSinceEpoch(
                            v['time'] * 1000));
                  }).toList();
                }
                dataValues.sort(
                    (DataValue a, DataValue b) => a.time.compareTo(b.time));

                return Sensor(
                    model: model,
                    location: location,
                    name: name,
                    sensorID: sensorID,
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
      connected = false;
      globalChannel?.sink.close(4000, "");
    }
    await Future.delayed(const Duration(seconds: 10));
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
