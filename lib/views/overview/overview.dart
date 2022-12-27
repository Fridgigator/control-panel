import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/view_model/main_view/overview.dart';
import 'package:control_panel/views/overview/fridge_overview_display.dart';
import 'package:control_panel/views/overview/overview_connection_stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Overview extends MainWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Overview({
    super.key,
    required this.darkTheme,
    required this.smallDevice,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => OverviewViewModel())],
        builder: (context, child) {
          return ListView(
              padding: smallDevice
                  ? const EdgeInsets.fromLTRB(8, 32, 8, 32)
                  : const EdgeInsets.fromLTRB(128, 32, 128, 32),
              scrollDirection: Axis.vertical,
              children: [
                MainConnectionStat(
                    darkTheme: darkTheme,
                    amountUp: Provider.of<OverviewViewModel>(context).amountUp,
                    amountDown:
                        Provider.of<OverviewViewModel>(context).amountDown,
                    hasPinged:
                        Provider.of<OverviewViewModel>(context).hasPinged),
                Center(
                    child: Wrap(
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.spaceAround,
                  children: Provider.of<OverviewViewModel>(context)
                      .fridges
                      .map((e) => FridgeOverviewDisplay(fridge: e))
                      .toList(),
                )),
              ]);
        });
  }

  @override
  Widget getSideBar(BuildContext context) {
    return ListView(
        children: Provider.of<OverviewViewModel>(context)
            .fridges
            .map((e) => ListTile(
                  title: Text(e.name),
                  onTap: () {},
                ))
            .toList());
  }

  @override
  bool hasSideBar() {
    return true;
  }

  @override
  FloatingActionButton? getFAB(BuildContext context) {
    return null;
  }
}
