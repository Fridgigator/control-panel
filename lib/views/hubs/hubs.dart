import 'dart:developer';

import 'package:control_panel/data_structures/hubs.dart';
import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/view_model/main_view/hubs.dart';
import 'package:control_panel/views/hubs/hub_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Hubs extends MainWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Hubs({super.key, required this.darkTheme, required this.smallDevice});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => HubsViewModel())],
        builder: (context, child) {
          return Center(
            child: Provider.of<HubsViewModel>(context).finishedLoading
                ? SingleChildScrollView(
                    child: Wrap(
                      direction: Axis.horizontal,
                      children:
                          Provider.of<HubsViewModel>(context).hubs.map((Hub h) {
                        log("hub: $h");
                        return HubView(
                            key: ValueKey(h.id),
                            darkTheme: darkTheme,
                            hubUUID: h.id,
                            lastSeenTimes: h.pings);
                      }).toList(),
                    ),
                  )
                : const CircularProgressIndicator(),
          );
        });
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

  @override
  FloatingActionButton? getFAB(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add));
  }
}
