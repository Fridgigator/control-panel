import 'package:flutter/material.dart';

class FridgeDrawer extends StatelessWidget {
  final bool darkTheme;
  const FridgeDrawer({super.key, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage('assets/manyFridges.png'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
                fit: BoxFit.fill),
          ),
          child: Container(
            alignment: Alignment.bottomLeft,
            height: 24,
            child: Text("Fridges",
                style: TextStyle(
                    color: darkTheme ? Colors.white70 : Colors.black87,
                    fontSize: 32)),
          ),
        ),
        ListTile(
          title: const Text('Item 1'),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.add_box),
          title: const Text("Add Fridge"),
          onTap: () {},
        ),
      ],
    ));
  }
}
