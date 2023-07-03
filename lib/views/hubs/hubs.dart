import 'package:control_panel/data_structures/hubs.dart';
import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/view_model/main_view/hubs.dart';
import 'package:control_panel/views/hubs/hub_view.dart';
import 'package:control_panel/views/old_views/add_hub.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Hubs extends MainWidget {
  final bool darkTheme;
  final bool smallDevice;
  final String accessToken;
  const Hubs(
      {super.key,
      required this.darkTheme,
      required this.smallDevice,
      required this.accessToken});

  @override
  State<StatefulWidget> createState() => _HubsState();

  @override
  FloatingActionButton? getFAB(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('Add Hub'),
                    content: AddHub(accessToken: accessToken));
              });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add));
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
}

class _HubsState extends State<Hubs> {
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
                        return HubView(
                            key: ValueKey(h.id),
                            darkTheme: widget.darkTheme,
                            hubUUID: h.id,
                            lastSeenTimes: h.pings);
                      }).toList(),
                    ),
                  )
                : const CircularProgressIndicator(),
          );
        });
  }
}
