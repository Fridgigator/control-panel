import 'package:flutter/material.dart';

class Sensors extends StatelessWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Sensors(
      {super.key, required this.darkTheme, required this.smallDevice});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("hubs"));
  }
}
