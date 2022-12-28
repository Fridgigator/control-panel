import 'package:flutter/material.dart';
import 'package:control_panel/data_structures/main_widget.dart';

import '../data_structures/main_view_state.dart';

class MainNavigationRail extends StatelessWidget {
  final MainViewState viewState;
  final Function(int?) changeViewState;
  final MainWidget mainView;
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
      Expanded(child: mainView)
      // This is the main content.
    ]);
  }
}
