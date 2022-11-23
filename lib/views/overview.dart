import 'package:flutter/cupertino.dart';

import 'fridge_overview_display.dart';
import 'main_connection_stats.dart';

class Overview extends StatelessWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Overview(
      {super.key, required this.darkTheme, required this.smallDevice});

  @override
  Widget build(BuildContext context) {
    List<FridgeOverviewDisplay> fridgeCounts = [
      FridgeOverviewDisplay(
        fridgeName: "Top Fridge",
        highHumidity: 20.334,
        lowHumidity: 1.33,
        lowTemp: 4,
        highTemp: 20,
        medianTemp: -5,
      ),
      FridgeOverviewDisplay(
        fridgeName: "Back Fridge",
        highHumidity: 20.334,
        lowHumidity: 1.33,
        lowTemp: 4,
        highTemp: 20,
        medianTemp: 5,
      ),
      FridgeOverviewDisplay(
        fridgeName: "Side Fridge",
        highHumidity: 20.334,
        lowHumidity: 1.33,
        lowTemp: 4,
        highTemp: 20,
        medianTemp: 15,
      ),
    ];
    return ListView(
        padding: smallDevice
            ? EdgeInsets.fromLTRB(8, 32, 8, 32)
            : EdgeInsets.fromLTRB(128, 32, 128, 32),
        scrollDirection: Axis.vertical,
        children: [
          MainConnectionStat(darkTheme: darkTheme),
          Center(
              child: Wrap(
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.spaceAround,
            children: fridgeCounts,
          )),
        ]);
  }
}
