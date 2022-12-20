import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/views/hubs/sensor_view.dart';
import 'package:flutter/material.dart';

class Hubs extends MainWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Hubs({super.key, required this.darkTheme, required this.smallDevice});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
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
    ])));
  }

  @override
  Widget getSideBar(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Hub 1'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Hub 2'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Hub 3'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Hub 4'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Hub 5'),
          onTap: () {},
        ),
      ],
    );
  }

  @override
  bool hasSideBar() {
    return true;
  }
}
