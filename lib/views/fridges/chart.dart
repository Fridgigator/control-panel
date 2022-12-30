import 'package:control_panel/data_structures/data_value.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Chart extends StatelessWidget {
  final bool darkTheme;
  final List<DataValue> dataValues;
  final DateTime now;
  final bool isTemp;
  final List<String>? toolTipsText;
  const Chart(
      {super.key,
      required this.darkTheme,
      required this.isTemp,
      required this.now,
      required this.dataValues,
      this.toolTipsText});

  double? get maxValue => dataValues.fold(null, (previousValue, element) {
        if (previousValue == null) {
          return element.value;
        } else {
          if (previousValue > element.value) {
            return previousValue;
          } else {
            return element.value;
          }
        }
      });
  double? get minValue => dataValues.fold(null, (previousValue, element) {
        if (previousValue == null) {
          return element.value;
        } else {
          if (previousValue < element.value) {
            return previousValue;
          } else {
            return element.value;
          }
        }
      });

  LineChartData get sampleData1 => LineChartData(
        gridData: gridData,
        lineTouchData: LineTouchData(
          enabled: toolTipsText != null,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((LineBarSpot barSpot) {
                return LineTooltipItem(
                    "${barSpot.y}", TextStyle(inherit: true));
              }).toList();
            },
          ),
        ),
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: 30,
        maxY: maxValue ?? 4 + 3,
        minY: minValue ?? -4 - 3,
      );

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

  List<LineChartBarData> get lineBarsData => [
        lineChartBarDataTemp,
        lineChartBarDataPicoTemp,
        lineChartBarDataDHT22Temp,
        lineChartBarDataDHT11Temp,
        lineChartBarDataHumidity,
        lineChartBarDataDHT22Humidity,
        lineChartBarDataDHT11Humidity,
        if (isTemp) high,
        if (isTemp) low
      ];

  List<FlSpot> get tempSpots => getSpots(TypeOfData.temp, now);
  List<FlSpot> get dht22TempSpots => getSpots(TypeOfData.dht22Temp, now);
  List<FlSpot> get dht11TempSpots => getSpots(TypeOfData.dht11Temp, now);
  List<FlSpot> get picoSpots {
    var spots = getSpots(TypeOfData.picoTemp, now);
    return spots;
  }

  List<FlSpot> get humiditySpots => getSpots(TypeOfData.humidity, now);
  List<FlSpot> get dht22HumiditySpots =>
      getSpots(TypeOfData.dht22Humidity, now);
  List<FlSpot> get dht11HumiditySpots =>
      getSpots(TypeOfData.dht11Humidity, now);

  List<FlSpot> getSpots(TypeOfData type, DateTime now) {
    List<FlSpot> dataValues = this.dataValues.where((DataValue v) {
      return v.typeOfData == type;
    }).map((DataValue v) {
      return Tuple2(v.time, v.value);
    }).map((Tuple2<DateTime, double> t) {
      return FlSpot(
          now.millisecondsSinceEpoch / 1000 -
              t.item1.millisecondsSinceEpoch / 1000,
          t.item2);
    }).toList();
    return dataValues;
  }

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
        color: Colors.grey,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: dht11TempSpots,
      );

  LineChartBarData get lineChartBarDataDHT22Humidity => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.orange,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: dht22HumiditySpots,
      );

  LineChartBarData get lineChartBarDataDHT11Humidity => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.green,
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
