/*import 'dart:convert';

import 'package:control_panel/constants.dart';
import 'package:control_panel/data_structures/data_value.dart';
import 'package:control_panel/data_structures/sensor.dart';
import 'package:control_panel/data_structures/sensor_data.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:quiver/iterables.dart';
import 'package:tuple/tuple.dart';

class SensorStatsViewModel with ChangeNotifier {
  SensorStatsViewModel({required this.accessToken, required this.sensor});
  final String accessToken;
  final Sensor sensor;

  DateTime _earlierTime = DateTime.fromMicrosecondsSinceEpoch(0);
  DateTime _laterTime = DateTime.now();
  Map<TypeOfData, List<SensorData>> _dataMap = {};
  bool _isUpdating = false;

  DateTime get earlierTime => _earlierTime;
  DateTime get laterTime => _laterTime;
  Map<TypeOfData, List<SensorData>> get dataMap => _dataMap;
  bool get isUpdating => _isUpdating;

  void setEarlierTime(DateTime earlierTime, Function(String text) doPopup) {
    _earlierTime = earlierTime;
    getData(doPopup);
    notifyListeners();
  }

  void setLaterTime(DateTime laterTime, Function(String text) doPopup) {
    _laterTime = laterTime;
    getData(doPopup);
    notifyListeners();
  }

  set dataMap(Map<TypeOfData, List<SensorData>> dataMap) {
    _dataMap = dataMap;
    notifyListeners();
  }

  set isUpdating(bool isUpdating) {
    _isUpdating = isUpdating;
    notifyListeners();
  }

  void getData(Function(String text) doPopup) async {
    isUpdating = true;
    try {
      var body = (await http.post(
          Uri.parse(
              "$remoteHttpDomain/api/frontend/v2/get-sensor-stat?sensor-key=${Uri.encodeQueryComponent(sensor.name)}"),
          headers: {"Authorization": accessToken}));
      if (body.statusCode != 200) {
        doPopup("Server error");
        debugPrint("${body.statusCode} != 200");
        isUpdating = false;
      } else {
        var returnMap = jsonDecode(body.body);

      }
    } catch (e, stacktrace) {
      debugPrint("Error: $e, $stacktrace");
      isUpdating = false;
    }
    /*try {
      var body = (await http.post(
          Uri.parse(
              "$remoteHttpDomain/api/frontend/v2/get-full-data?sensor-key=${Uri.encodeQueryComponent(sensor.name)}&start-date=${earlierTime.millisecondsSinceEpoch ~/ 1000}&end-date=${laterTime.millisecondsSinceEpoch ~/ 1000}"),
          headers: {"Authorization": accessToken}));
      if (body.statusCode != 200) {
        doPopup("Server error");
        debugPrint("${body.statusCode} != 200");
        isUpdating = false;
      } else {
        var returnMap = jsonDecode(body.body);
        if (returnMap["error-code"] == 0) {
          List<Map<String, dynamic>> data = returnMap["data"];
          Map<TypeOfData, List<Tuple2<DateTime, double>>> intermediateDataMap =
              {};
          Map<TypeOfData, List<SensorData>> newDataMap = {};
          for (Map<String, dynamic> m in data) {
            TypeOfData typeOfData;
            switch (m['type-of-data'] as int) {
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
            DateTime date =
                DateTime.fromMillisecondsSinceEpoch(m['time'] * 1000);
            double val = m['value'];
            intermediateDataMap.putIfAbsent(typeOfData, () => []);
            intermediateDataMap[typeOfData]
                ?.add(Tuple2<DateTime, double>(date, val));
            // Remove Data types that don't map to any data values
            for (TypeOfData t in intermediateDataMap.keys) {
              var val = intermediateDataMap[t];
              if (val?.isEmpty == true) {
                intermediateDataMap.remove(t);
              } else if (val != null) {
                val.sort(
                    (Tuple2<DateTime, double> a, Tuple2<DateTime, double> b) =>
                        a.item1.compareTo(b.item1));
                newDataMap.putIfAbsent(t, () => []);
                List<SensorData> v = partition(val, 2)
                    .map((List<Tuple2<DateTime, double>> v) {
                      v.sort((Tuple2<DateTime, double> a,
                              Tuple2<DateTime, double> b) =>
                          a.item1.compareTo(b.item1));
                      if (v.isEmpty) {
                        return null;
                      }
                      if (v.length == 1) {
                        return SensorData(
                            valLow: v.first.item2,
                            valHigh: v.first.item2,
                            startTime: v.first.item1,
                            endTime: v.first.item1);
                      }

                      DateTime startTime = v.first.item1;
                      DateTime endTime = v.first.item1;

                      assert(startTime.isBefore(endTime));

                      double valHigh =
                          max(v, (a, b) => a.item2.compareTo(b.item2))!.item2;
                      double valLow =
                          min(v, (a, b) => a.item2.compareTo(b.item2))!.item2;
                      return SensorData(
                          valLow: valLow,
                          valHigh: valHigh,
                          startTime: startTime,
                          endTime: endTime);
                    })
                    .where((v) => v != null)
                    .toList() as List<SensorData>;
                newDataMap[t] = v;
              }
            }
          }
          dataMap = newDataMap;
          isUpdating = false;
          return;
        } else {
          doPopup("Server error");
          debugPrint("${body.statusCode} != 200");
          isUpdating = false;
        }
      }
    } catch (e, stacktrace) {
      debugPrint("Error: $e, $stacktrace");
      isUpdating = false;
    }
    */
  }
}
*/