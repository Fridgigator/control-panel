import 'package:flutter/material.dart';

import '../data_structures/main_view_state.dart';

class MainNavigationRail extends StatelessWidget {
  final MainViewState viewState;
  final Function(int?) changeViewState;
  final Widget mainView;
  const MainNavigationRail(
      {super.key,
      required this.viewState,
      required this.changeViewState,
      required this.mainView});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      NavigationRail(
        selectedIndex: viewState.index,
        onDestinationSelected: changeViewState,
        labelType: NavigationRailLabelType.selected,
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home_filled),
            label: Text('Home'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.hub_outlined),
            selectedIcon: Icon(Icons.hub),
            label: Text('Hubs'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.sensors_outlined),
            selectedIcon: Icon(Icons.sensors),
            label: Text('Sensors'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.crop_square_outlined),
            selectedIcon: Icon(Icons.square),
            label: Text('Fridges'),
          ),
          NavigationRailDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: Text('Settings'),
          ),
        ],
      ),
      const VerticalDivider(thickness: 1, width: 1),
      SizedBox(
          width: 304.0,
          child: ListView(
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
          )),
      const VerticalDivider(thickness: 1, width: 1),
      mainView
      // This is the main content.
    ]);
  }
}
