import 'package:control_panel/data_structures/fridge.dart';
import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';

class FridgeOverviewDisplay extends StatelessWidget {
  final Fridge fridge;
  const FridgeOverviewDisplay({super.key, required this.fridge});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(children: [
                  Text(fridge.name),
                  Container(
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
                                minAngle: 10,
                                maxAngle: 150,
                                color: Colors.blue,
                              ),
                              const RadialGaugeSegment(
                                minValue: 0,
                                maxValue: 10,
                                minAngle: -50,
                                maxAngle: 50,
                                color: Colors.green,
                              ),
                              const RadialGaugeSegment(
                                minValue: 10,
                                maxValue: 20,
                                minAngle: -150,
                                maxAngle: -50,
                                color: Colors.red,
                              ),
                            ],
                            minValue: -200,
                            maxValue: 200,
                            minAngle: -150,
                            maxAngle: 150,
                          ),
                        ],
                      )),
                  IntrinsicWidth(
                      child: Column(children: [
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${fridge.medianTemp} C"),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                          ),
                          Text("${fridge.lowTemp} C")
                        ]),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${fridge.highHumidity}%"),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                          ),
                          Text("${fridge.lowHumidity}%")
                        ])
                  ]))
                ]))));
  }
}
