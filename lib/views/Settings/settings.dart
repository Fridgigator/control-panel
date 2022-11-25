import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Settings(
      {super.key, required this.darkTheme, required this.smallDevice});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("hubs"));
  }
}
