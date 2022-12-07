import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';
import 'package:im_animations/im_animations.dart';

import 'chart.dart';

class FridgeCard extends StatelessWidget {
  final bool darkTheme;
  const FridgeCard({super.key, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(24),
        child: IntrinsicWidth(
            child: Card(
                elevation: 8,
                child: Column(children: [
                  Row(children: const [
                    Padding(padding: EdgeInsets.fromLTRB(16, 32, 8, 8)),
                    Padding(padding: EdgeInsets.fromLTRB(0, 8, 8, 8)),
                    Text("Fridge a")
                  ]),
                  Card(
                      elevation: 8,
                      child: Column(children: [
                        Row(children: const [
                          Padding(padding: EdgeInsets.fromLTRB(16, 32, 8, 8)),
                          Padding(padding: EdgeInsets.fromLTRB(0, 8, 8, 8)),
                          Text("Sensor a")
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RadialGauge(
                                radius: 60,
                                axes: [
                                  RadialGaugeAxis(
                                    pointers: [
                                      RadialNeedlePointer(
                                        value: 22,
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
                              )
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 128,
                                width: 256,
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 32, 16, 8),
                                    child: Chart(darkTheme: darkTheme)),
                              )
                            ]),
                      ])),
                  Card(
                      elevation: 8,
                      child: Column(children: [
                        Row(children: const [
                          Padding(padding: EdgeInsets.fromLTRB(16, 32, 8, 8)),
                          Padding(padding: EdgeInsets.fromLTRB(0, 8, 8, 8)),
                          Text("Sensor a")
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 128,
                                width: 256,
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 32, 16, 8),
                                    child: Chart(darkTheme: darkTheme)),
                              )
                            ]),
                      ]))
                ]))));
  }
}
