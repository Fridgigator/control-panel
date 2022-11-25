import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';

class FridgeOverviewDisplay extends StatelessWidget {
  final double medianTemp;
  final double highTemp;
  final double lowTemp;

  final double highHumidity;
  final double lowHumidity;
  final String fridgeName;
  const FridgeOverviewDisplay(
      {super.key,
      required this.fridgeName,
      required this.medianTemp,
      required this.highTemp,
      required this.lowTemp,
      required this.highHumidity,
      required this.lowHumidity});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(children: [
                  Text(fridgeName),
                  Container(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      child: RadialGauge(
                        radius: 60,
                        axes: [
                          RadialGaugeAxis(
                            pointers: [
                              RadialNeedlePointer(
                                value: medianTemp,
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
                          Text("$highTemp C"),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                          ),
                          Text("$lowTemp C")
                        ]),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("$highHumidity%"),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                          ),
                          Text("$lowHumidity%")
                        ])
                  ]))
                ]))));
  }
}
