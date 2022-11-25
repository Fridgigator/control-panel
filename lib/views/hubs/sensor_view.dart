import 'package:flutter/material.dart';
import 'package:im_animations/im_animations.dart';

import 'chart.dart';

class SensorView extends StatelessWidget {
  final bool darkTheme;
  const SensorView({super.key, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: Card(
            child: Column(children: [
      Row(children: [
        Padding(padding: EdgeInsets.fromLTRB(16, 32, 8, 8)),
        ColorSonar(
          contentAreaColor: darkTheme ? Colors.black12 : Colors.white,
          duration: Duration(milliseconds: 1000),
          contentAreaRadius: 2.0,
          waveFall: 2,
          innerWaveColor: darkTheme ? Colors.lightGreenAccent : Colors.green,
          middleWaveColor:
              darkTheme ? Colors.yellowAccent : Colors.lightGreenAccent,
          outerWaveColor: darkTheme
              ? Color.fromARGB(255, 227, 255, 162)
              : Colors.yellowAccent,
          child: CircleAvatar(
            backgroundColor: darkTheme ? Colors.lightGreenAccent : Colors.green,
            radius: 4,
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 8, 8, 8)),
        Text("Sensor a")
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          height: 128,
          width: 256,
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
              child: Chart(darkTheme: darkTheme)),
        )
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(padding: EdgeInsets.fromLTRB(8, 8, 8, 8), child: Text("Logs")),
        Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.open_in_full)))
      ]),
      Row(children: [
        SizedBox(
            width: 256,
            height: 256,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: ListView(shrinkWrap: true, children: [Text("test")]),
            ))
      ])
    ])));
  }
}
