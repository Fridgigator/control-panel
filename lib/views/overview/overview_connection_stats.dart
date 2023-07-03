import 'package:flutter/material.dart';

import 'package:radar/main.dart';

class MainConnectionStat extends StatelessWidget {
  final bool darkTheme;
  final bool hasPinged;
  final int amountUp;
  final int amountDown;
  const MainConnectionStat(
      {super.key,
      required this.darkTheme,
      required this.hasPinged,
      required this.amountDown,
      required this.amountUp,
      required this.angle,
      required this.points});
  final Color leftBarColor = const Color(0xffff5182);
  final Color rightBarColor = const Color(0xff53fdd7);
  final double width = 7;
  final int angle;
  final int radius = 240;
  final Map<int, List<String>> points;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 2 * radius + 64,
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text("Connection status"),
              Container(
                width: 2 * radius + 8,
                height: 2 * radius + 8,
                margin: const EdgeInsets.fromLTRB(16.0, 36, 16, 16),
                child: Radar(
                    angle: angle, points: points, radius: radius.toDouble()),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text("$amountUp up"), Text("$amountDown down")])
            ],
          ),
        ),
      ),
    );
  }
}
