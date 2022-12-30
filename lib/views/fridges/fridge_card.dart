import 'dart:developer';

import 'package:control_panel/data_structures/data_value.dart';
import 'package:control_panel/data_structures/fridge.dart';
import 'package:control_panel/data_structures/sensor.dart';
import 'package:control_panel/views/fridges/remove_fridge/remove_fridge_dialog.dart';
import 'package:control_panel/views/old_views/add_sensor.dart';
import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';

import 'chart.dart';

class FridgeCard extends StatelessWidget {
  final bool darkTheme;
  final Fridge fridge;
  final String accessToken;
  final bool isCentigrade;
  final void Function(Sensor sensor)? onCardTap;
  const FridgeCard(
      {super.key,
      required this.darkTheme,
      required this.fridge,
      required this.isCentigrade,
      required this.accessToken,
      required this.onCardTap});

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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text('Add Sensor'),
                                  content: AddSensor(
                                    accessToken: accessToken,
                                    fridges: [],
                                  ));
                            });
                      },
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
                            isCentigrade: isCentigrade,
                            onCardTap: onCardTap,
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
  final void Function(Sensor sensos)? onCardTap;
  final bool isCentigrade;
  const _IndividualSensorWidget({
    Key? key,
    required this.now,
    required this.darkTheme,
    required this.isCentigrade,
    required this.sensor,
    required this.onCardTap,
  }) : super(key: key);

  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    List<DataValue> tempLists = sensor.dataValues
        .where((DataValue v) =>
            v.typeOfData == TypeOfData.dht11Temp ||
            v.typeOfData == TypeOfData.dht22Temp ||
            v.typeOfData == TypeOfData.picoTemp ||
            v.typeOfData == TypeOfData.temp)
        .toList();
    List<DataValue> humidityLists = sensor.dataValues
        .where((DataValue v) =>
            v.typeOfData == TypeOfData.dht11Humidity ||
            v.typeOfData == TypeOfData.dht22Humidity ||
            v.typeOfData == TypeOfData.humidity)
        .toList();
    double? latestTemp;
    try {
      latestTemp = tempLists.last.value;
    } catch (_) {}
    void Function(Sensor sensor)? onCardTap = this.onCardTap;
    return InkWell(
      onTap: onCardTap == null
          ? null
          : () {
              onCardTap(sensor);
            },
      child: Card(
        elevation: 8,
        child: Column(
          children: [
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
                      latestTemp: latestTemp, dataValues: tempLists))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              SizedBox(
                height: 128,
                width: 256,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                  child: Chart(
                    now: now,
                    isTemp: true,
                    darkTheme: darkTheme,
                    isCentigrade: isCentigrade,
                    dataValues: tempLists
                        .where((DataValue t) => t.time
                            .isAfter(now.subtract(const Duration(seconds: 30))))
                        .toList(),
                  ),
                ),
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 128,
                  width: 256,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                    child: Chart(
                      isTemp: false,
                      now: now,
                      isCentigrade: true,
                      darkTheme: darkTheme,
                      dataValues: humidityLists
                          .where((DataValue t) => t.time.isAfter(
                              now.subtract(const Duration(seconds: 30))))
                          .toList(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
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
