import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ViewData extends StatefulWidget {
  final String sensorKey;
  final DateTime timeCalled;
  const ViewData({Key? key, required this.sensorKey, required this.timeCalled})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<ViewData> {
  final Color leftBarColor = const Color(0xffff5182);
  final Color rightBarColor = const Color(0xff53fdd7);
  final double width = 7;

  List<BarChartGroupData> showingBarGroups = [];

  @override
  void initState() {
    super.initState();

    () async {
      debugPrint("key=${widget.sensorKey}");
      http.Response r = await http.get(Uri.parse(
          'https://fridgigator.herokuapp.com/api/v1/get-sensor-stat?sensor-key=${widget.sensorKey}'));
      if (r.statusCode != 200) {
        const snackBar = SnackBar(
          content: Text("There's a bug in the backend"),
        );
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      }
      var jsonData = json.decode(r.body);
      List<BarChartGroupData> items = [];
      for (int i = jsonData.length - 1; i >= 0; i--) {
        var v = jsonData[i];
        items.add(makeGroupData(
            i,
            (v["twentyFifth"] * 100).round().toDouble() / 100.0,
            (v["seventyFifth"] * 100).round().toDouble() / 100.0));
      }
      if (items.isEmpty) {
        const snackBar = SnackBar(
          content: Text("No data was received"),
        );
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      }
      if (!mounted) {
        return;
      }
      setState(() {
        showingBarGroups = items;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return showingBarGroups.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : AspectRatio(
            aspectRatio: 1,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: const Color(0xff2c4260),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          maxY: 50,
                          barTouchData: BarTouchData(
                              handleBuiltInTouches: true,
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.grey,
                              )),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: bottomTitles,
                                reservedSize: 42,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                                interval: 1,
                                getTitlesWidget: leftTitles,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: showingBarGroups,
                          gridData: FlGridData(show: false),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0° C';
    } else if (value == 5) {
      text = '5° C';
    } else if (value == 10) {
      text = '10° C';
    } else if (value == 15) {
      text = '15° C';
    } else if (value == 20) {
      text = '20° C';
    } else if (value == 25) {
      text = '25° C';
    } else if (value == 30) {
      text = '30° C';
    } else if (value == 35) {
      text = '35° C';
    } else if (value == 40) {
      text = '40° C';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<String> titles = [];

    for (int i = 0; i < 10; i++) {
      titles.add(DateFormat('kk:mm')
          .format(DateTime.now().subtract(const Duration(minutes: 15) * i)));
    }

    Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        toY: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        toY: y2,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }
}
