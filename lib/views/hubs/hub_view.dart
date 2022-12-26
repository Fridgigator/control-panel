import 'package:flutter/material.dart';
import 'package:im_animations/im_animations.dart';

import 'chart.dart';

class HubView extends StatelessWidget {
  final bool darkTheme;
  final String hubUUID;
  final List<DateTime> lastSeenTimes;

  const HubView(
      {super.key,
      required this.darkTheme,
      required this.hubUUID,
      required this.lastSeenTimes});

  @override
  Widget build(BuildContext context) {
    bool notConnected = false;
    var curTime = DateTime.now();
    DateTime tmpLastPing = DateTime.fromMicrosecondsSinceEpoch(0);
    for (DateTime dt in lastSeenTimes) {
      if (tmpLastPing.isBefore(dt)) {
        tmpLastPing = dt;
      }
    }
    notConnected = curTime.difference(tmpLastPing) > const Duration(seconds: 5);
    return IntrinsicWidth(
        key: key,
        child: Card(
            child: Column(children: [
          Row(children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 32, 16, 0)),
            ColorSonar(
              wavesDisabled: notConnected,
              contentAreaColor: darkTheme ? Colors.black12 : Colors.white,
              duration: const Duration(milliseconds: 1000),
              contentAreaRadius: 2.0,
              waveFall: 2,
              innerWaveColor:
                  darkTheme ? Colors.lightGreenAccent : Colors.green,
              middleWaveColor:
                  darkTheme ? Colors.yellowAccent : Colors.lightGreenAccent,
              outerWaveColor: darkTheme
                  ? const Color.fromARGB(255, 227, 255, 162)
                  : Colors.yellowAccent,
              child: CircleAvatar(
                backgroundColor: notConnected
                    ? (darkTheme ? Colors.pinkAccent : Colors.red)
                    : (darkTheme ? Colors.lightGreenAccent : Colors.green),
                radius: 4,
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 8, 8)),
            Text(hubUUID),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 16, 8)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
              height: 128,
              width: 256,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                  child: Chart(
                      darkTheme: darkTheme, lastSeenTimes: lastSeenTimes)),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8), child: Text("Logs")),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.open_in_full)))
          ]),
          Row(children: [
            SizedBox(
                width: 256,
                height: 256,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: ListView(shrinkWrap: true, children: const [
                    Text(
                        "This is where the logs will go when we start sending them to the server")
                  ]),
                ))
          ])
        ])));
  }
}
