import 'package:control_panel/data_structures/fridge.dart';
import 'package:control_panel/data_structures/sensor.dart';
import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';

class FridgeOverviewDisplay extends StatelessWidget {
  final Fridge fridge;
  final bool centigrade;
  const FridgeOverviewDisplay(
      {super.key, required this.fridge, required this.centigrade});

  @override
  Widget build(BuildContext context) {
    String highTempDisplay = centigrade
        ? "${fridge.highTemp.toStringAsFixed(2)} C"
        : "${cToF(fridge.highTemp).toStringAsFixed(2)} F";
    String lowTempDisplay = centigrade
        ? "${fridge.lowTemp.toStringAsFixed(2)} C"
        : "${cToF(fridge.lowTemp).toStringAsFixed(2)} F";
    bool dataReceived = false;
    if (fridge.sensors.isNotEmpty) {
      for (Sensor s in fridge.sensors) {
        if (s.dataValues.isNotEmpty) {
          dataReceived = true;
          break;
        }
      }
    }
    return Card(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Column(
            children: [
              Text(fridge.name),
              !dataReceived
                  ? const Icon(Icons.error)
                  : Container(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      child: RadialGauge(
                        radius: 60,
                        axes: [
                          RadialGaugeAxis(
                            pointers: [
                              RadialNeedlePointer(
                                value: fridge.medianTemp,
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
                        ],
                      ),
                    ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        dataReceived ? Text(highTempDisplay) : const Text(""),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                        ),
                        dataReceived ? Text(lowTempDisplay) : const Text("")
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        dataReceived
                            ? Text("${fridge.highHumidity.toStringAsFixed(2)}%")
                            : const Text(""),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                        ),
                        dataReceived
                            ? Text("${fridge.lowHumidity.toStringAsFixed(2)}%")
                            : const Text("")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

double cToF(double tempC) {
  return (tempC * 9.0 / 5.0) + 32.0;
}
