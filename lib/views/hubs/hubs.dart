import 'package:flutter/material.dart';

class Hubs extends StatelessWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Hubs({super.key, required this.darkTheme, required this.smallDevice});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("hubs"));
  }
}
