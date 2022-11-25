import 'package:control_panel/views/hubs/chart.dart';
import 'package:control_panel/views/hubs/sensor_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:im_animations/im_animations.dart';

class Hubs extends StatelessWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Hubs({super.key, required this.darkTheme, required this.smallDevice});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Wrap(direction: Axis.horizontal, children: [
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
      SensorView(
        darkTheme: darkTheme,
      ),
    ]));
  }
}
