import 'dart:developer';

import 'package:control_panel/data_structures/data_value.dart';
import 'package:control_panel/data_structures/fridge.dart';
import 'package:control_panel/data_structures/sensor.dart';
import 'package:control_panel/views/fridges/remove_fridge/remove_fridge_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';

import 'chart.dart';

class FridgeCard extends StatelessWidget {
  final bool darkTheme;
  final Fridge fridge;
  final String accessToken;
  const FridgeCard(
      {super.key,
      required this.darkTheme,
      required this.fridge,
      required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: IntrinsicWidth(
            child: Card(
                elevation: 8,
                child: Column(children: [
                  Row(children: [
                    const Padding(padding: EdgeInsets.fromLTRB(16, 32, 8, 8)),
                    Text(fridge.name),
                    const Padding(padding: EdgeInsets.fromLTRB(8, 32, 8, 8)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(8, 32, 16, 8)),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        RemoveDialog.startDialog(
                            context, accessToken, fridge.id, fridge.name);
                      },
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(8, 32, 16, 8)),
                  ]),
                  for (Sensor s in fridge.sensors)
                    s.dataValues.isNotEmpty
                        ? _IndividualSensorWidget(
                            now: DateTime.now(),
                            key: ValueKey(s.name),
                            darkTheme: darkTheme,
                            sensor: s)
                        : Container(),
                ]))));
  }
}

class _IndividualSensorWidget extends StatelessWidget {
  final Sensor sensor;
  final DateTime now;
  const _IndividualSensorWidget({
    Key? key,
    required this.now,
    required this.darkTheme,
    required this.sensor,
  }) : super(key: key);

  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    List<DataValue> tempLists = sensor.dataValues
        .where((DataValue v) =>
            v.typeOfData == TypeOfData.dht11Temp ||
            v.typeOfData == TypeOfData.dht22Temp ||
            v.typeOfData == TypeOfData.temp)
        .toList();

    double? latestTemp;
    try {
      log("sensor.dataValues.last=${tempLists.last}");

      latestTemp = tempLists.last.value;
    } catch (_) {
      log("not found");
    }
    return Card(
        elevation: 8,
        child: Column(children: [
          Row(children: [
            const Padding(padding: EdgeInsets.fromLTRB(16, 32, 8, 8)),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 8, 8)),
            Text("Sensor ${sensor.location}")
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                height: 120,
                width: 120,
                child: _MyRadialGauge(
                    latestTemp: latestTemp, dataValues: sensor.dataValues))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
              height: 128,
              width: 256,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                child: Chart(
                  now: now,
                  darkTheme: darkTheme,
                  dataValues: sensor.dataValues
                      .where((DataValue t) => t.time
                          .isAfter(now.subtract(const Duration(seconds: 30))))
                      .toList(),
                ),
              ),
            )
          ])
        ]));
  }
}

class _MyRadialGauge extends StatelessWidget {
  final double? latestTemp;
  final List<DataValue> dataValues;

  const _MyRadialGauge({required this.latestTemp, required this.dataValues});

  @override
  Widget build(context) {
    double? latestTemp = this.latestTemp;
    return (latestTemp == null)
        ? const Expanded(child: Icon(Icons.block))
        : RadialGauge(radius: 60, axes: [
            RadialGaugeAxis(
              pointers: [
                RadialNeedlePointer(
                  value: latestTemp,
                  thicknessStart: 8,
                  thicknessEnd: 2,
                  length: 1,
                ),
              ],
              segments: [
                const RadialGaugeSegment(
                  minValue: -20,
                  maxValue: 0,
                  minAngle: -150,
                  maxAngle: 0,
                  color: Colors.blue,
                ),
                const RadialGaugeSegment(
                  minValue: 0,
                  maxValue: 5,
                  minAngle: 0,
                  maxAngle: 37.5,
                  color: Colors.green,
                ),
                const RadialGaugeSegment(
                  minValue: 5,
                  maxValue: 10,
                  minAngle: 37.5,
                  maxAngle: 75,
                  color: Colors.orangeAccent,
                ),
                const RadialGaugeSegment(
                  minValue: 10,
                  maxValue: 20,
                  minAngle: 75,
                  maxAngle: 150,
                  color: Colors.red,
                ),
              ],
              minValue: -20,
              maxValue: 20,
              minAngle: -150,
              maxAngle: 150,
            ),
          ]);
  }
}
