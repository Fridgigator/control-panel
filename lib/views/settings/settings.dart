import 'package:control_panel/data_structures/main_widget.dart';
import 'package:flutter/material.dart';

class Settings extends MainWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Settings(
      {super.key, required this.darkTheme, required this.smallDevice});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("hubs"));
  }

  @override
  Widget getSideBar() {
    return ListView(
      children: [
        ListTile(
          title: const Text('Fridge 1'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Fridge 2'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Fridge 3'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Fridge 4'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Fridge 5'),
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
