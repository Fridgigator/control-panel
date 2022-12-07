import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/views/fridges/fridge_card.dart';
import 'package:flutter/material.dart';

class Fridges extends MainWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Fridges(
      {super.key, required this.darkTheme, required this.smallDevice});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Wrap(direction: Axis.horizontal, children: [
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
      FridgeCard(
        darkTheme: darkTheme,
      ),
    ]));
  }

  @override
  Widget getSideBar() {
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
