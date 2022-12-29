import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/data_structures/sensor.dart';
import 'package:control_panel/view_model/main_view/fridges/overview.dart';
import 'package:control_panel/views/fridges/add_fridge/add_fridge_dialog.dart';
import 'package:control_panel/views/fridges/fridge_card.dart';
import 'package:control_panel/views/fridges/sensor_stats/sensor_stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fridges extends MainWidget {
  final bool darkTheme;
  final bool smallDevice;
  final bool isCentigrade;
  final String accessToken;
  const Fridges(
      {super.key,
      required this.darkTheme,
      required this.smallDevice,
      required this.accessToken,
      required this.isCentigrade});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => FridgeViewModel())],
        builder: (context, child) {
          return Provider.of<FridgeViewModel>(context).finishedLoading
              ? SingleChildScrollView(
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: Provider.of<FridgeViewModel>(context)
                        .fridges
                        .map(
                          (fridge) => FridgeCard(
                            onCardTap: (Sensor sensor) {
                              if (!smallDevice) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            Text("Sensor: ${sensor.location}"),
                                        content: SensorStats(
                                          isCentigrade: isCentigrade,
                                          sensorKey: sensor.name,
                                          timeCalled: DateTime.now(),
                                        ),
                                      );
                                    });
                              }
                            },
                            darkTheme: darkTheme,
                            fridge: fridge,
                            accessToken: accessToken,
                          ),
                        )
                        .toList(),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
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
  FloatingActionButton? getFAB(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          if (!smallDevice) {
            AddDialog.startFridgeDialog(context, accessToken);
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddDialog.replaceMain(accessToken),
            ));
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add));
  }

  @override
  bool hasSideBar() {
    return true;
  }
}
