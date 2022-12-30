import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final bool darkTheme;
  final List<DateTime> lastSeenTimes;
  const Chart(
      {super.key, required this.darkTheme, required this.lastSeenTimes});

  List<FlSpot> get whenSeen {
    if (lastSeenTimes.isEmpty) {
      return [];
    }
    List<FlSpot> returnVal =
        List.generate(300, (index) => FlSpot(index.toDouble(), 0));
    int curTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    for (DateTime dt in lastSeenTimes) {
      if (curTime - dt.millisecondsSinceEpoch ~/ 1000 < returnVal.length) {
        returnVal[curTime - dt.millisecondsSinceEpoch ~/ 1000] =
            returnVal[curTime - dt.millisecondsSinceEpoch ~/ 1000]
                .copyWith(y: 4);
      }
    }
    returnVal = cleanup(returnVal);
    return returnVal;
  }

  LineChartData get sampleData1 => LineChartData(
        gridData: gridData,
        lineTouchData: LineTouchData(enabled: false),
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 300,
        maxY: 3,
        minY: 0,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
            //showTitles:,
            ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    if (value.toInt() % 5 == 0) {
      text = Text('${value.toInt()}');
    } else {
      text = const Text('');
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 60,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
      isCurved: true,
      curveSmoothness: 0,
      color: darkTheme ? Colors.lightGreenAccent : Colors.green,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: whenSeen);

  @override
  Widget build(BuildContext context) {
    return whenSeen.isNotEmpty
        ? LineChart(
            sampleData1,
            swapAnimationDuration: const Duration(milliseconds: 250),
          )
        : Container();
  }
}

bool isAheadFound(int index, List<FlSpot> input) {
  for (int i = index; i < input.length && i < index + 6; i++) {
    if (input[i].y > 0) {
      return true;
    }
  }
  return false;
}

bool isBeforeFound(int index, List<FlSpot> input) {
  for (int i = index; i >= 0 && i > index - 6; i--) {
    if (input[i].y > 0) {
      return true;
    }
  }
  return false;
}

List<FlSpot> cleanup(List<FlSpot> input) {
  List<FlSpot> returnVal = input;
  for (int i = 0; i < returnVal.length; i++) {
    if (isBeforeFound(i, input) && isAheadFound(i, input)) {
      returnVal[i] = returnVal[i].copyWith(y: 4);
    }
    if (i + 6 >= returnVal.length && isBeforeFound(i, input)) {
      returnVal[i] = returnVal[i].copyWith(y: 4);
    }
  }
  return returnVal;
}
