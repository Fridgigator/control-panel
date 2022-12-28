import 'package:flutter/material.dart';

import '../data_structures/main_view_state.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final MainViewState viewState;
  final Function(int?) changeViewState;
  const MainBottomNavigationBar(
      {super.key, required this.viewState, required this.changeViewState});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hub),
            label: 'Hubs',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.square),
            label: 'Fridges',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: viewState.index,
        selectedItemColor: Colors.amber[800],
        onTap: changeViewState);
  }
}
