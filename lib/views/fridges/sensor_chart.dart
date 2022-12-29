/*import 'package:control_panel/data_structures/data_value.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:tuple/tuple.dart';

class SensorChart extends StatelessWidget {
  final bool darkTheme;
  final List<Tuple2<double, double>> dataValues;
  final DateTime now;
  final List<String>? toolTipsText;
  const SensorChart(
      {super.key,
      required this.darkTheme,
      required this.now,
      required this.dataValues,
      this.toolTipsText});

  double? get maxValue => max(
      dataValues,
      (Tuple2<double, double> a, Tuple2<double, double> b) =>
          a.item2.compareTo(b.item2))?.item2;
  double? get minValue => min(
      dataValues,
      (Tuple2<double, double> a, Tuple2<double, double> b) =>
          a.item1.compareTo(b.item1))?.item1;

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: toolTipsText == null
              ? bottomTitles
              : SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 48.0),
        ),
      );

  List<LineChartBarData> get lineBarsData => [high, low];

  List<FlSpot>? get highPercentile =>
      enumerate(dataValues).map((dataValue, index) {
        return FlSpot((index as int), dataValue.value.item2);
      }).toList();
  //List<FlSpot> get lowPercentile =>

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
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: darkTheme ? Colors.amber.shade50 : Colors.indigo.shade900,
              width: 1),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(
              color: darkTheme ? Colors.amber.shade50 : Colors.indigo.shade900,
              width: 1),
        ),
      );

  LineChartBarData get lineChartBarDataTemp => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.indigo,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: tempSpots,
      );

  LineChartBarData get lineChartBarDataHumidity => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.indigo,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: humiditySpots,
      );

  LineChartBarData get lineChartBarDataPicoTemp => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.pink,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: picoSpots,
      );

  LineChartBarData get lineChartBarDataDHT22Temp => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.yellow,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: dht22TempSpots,
      );

  LineChartBarData get lineChartBarDataDHT11Temp => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.indigo,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: dht11TempSpots,
      );

  LineChartBarData get lineChartBarDataDHT22Humidity => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.yellow,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: dht22HumiditySpots,
      );

  LineChartBarData get lineChartBarDataDHT11Humidity => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.indigo,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: dht11HumiditySpots,
      );

  LineChartBarData get high => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.red,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0, 4),
          FlSpot(30, 4),
        ],
      );
  LineChartBarData get low => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.blue,
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0, 0),
          FlSpot(30, 0),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 100),
    );
  }
}
*/