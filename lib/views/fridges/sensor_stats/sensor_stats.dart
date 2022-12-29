/*import 'package:another_flushbar/flushbar_helper.dart';
import 'package:control_panel/data_structures/sensor.dart';
import 'package:control_panel/data_structures/sensor_data.dart';
import 'package:control_panel/view_model/main_view/fridges/sensor_stats.dart';
import 'package:control_panel/views/fridges/chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SensorStats extends StatelessWidget {
  final Sensor sensor;
  final bool darkTheme;
  final String accessToken;
  const SensorStats(
      {super.key,
      required this.sensor,
      required this.darkTheme,
      required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          var model = SensorStatsViewModel(accessToken: accessToken, sensor: sensor);
          model.getData((String msg) {
            FlushbarHelper.createError(message: msg).show(context);
          });
          return model;
        })
      ],
      builder: (context, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimePicker(
                    setDateTime: (DateTime newDate) {
                      Provider.of<SensorStatsViewModel>(context, listen: false)
                          .setEarlierTime(newDate, (String msg) {
                        FlushbarHelper.createError(message: msg).show(context);
                      });
                    },
                    key: const ValueKey("1"),
                    firstDateTime: DateTime.fromMillisecondsSinceEpoch(0),
                    lastDateTime:
                        Provider.of<SensorStatsViewModel>(context).laterTime,
                    curDateTime:
                        Provider.of<SensorStatsViewModel>(context).earlierTime),
                IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
                DateTimePicker(
                    key: const ValueKey("2"),
                    setDateTime: (DateTime newDate) {
                      Provider.of<SensorStatsViewModel>(context, listen: false)
                          .setLaterTime(newDate, (String msg) {
                        FlushbarHelper.createError(message: msg).show(context);
                      });
                    },
                    firstDateTime:
                        Provider.of<SensorStatsViewModel>(context).earlierTime,
                    lastDateTime: DateTime.now(),
                    curDateTime:
                        Provider.of<SensorStatsViewModel>(context).laterTime),
              ],
            ),
            SensorView(
              darkTheme: darkTheme,
              title: "DHT11 Humidity",
              sensorData: [],
            ),
          ],
        );
      },
    );
  }
}

class SensorView extends StatelessWidget {
  const SensorView({
    super.key,
    required this.darkTheme,
    required this.title,
    required this.sensorData,
  });
  final String title;
  final List<SensorData> sensorData;
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 256,
              height: 128,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 8, 0),
                child: Chart(
                  darkTheme: darkTheme,
                  isTemp: true,
                  now: DateTime.now(),
                  dataValues: [],
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

class DateTimePicker extends StatelessWidget {
  final Function(DateTime newDateTime) setDateTime;
  final DateTime curDateTime;
  final DateTime firstDateTime;
  final DateTime lastDateTime;
  const DateTimePicker(
      {super.key,
      required this.curDateTime,
      required this.firstDateTime,
      required this.lastDateTime,
      required this.setDateTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
                context: context,
                initialDatePickerMode: DatePickerMode.day,
                firstDate: firstDateTime,
                lastDate: lastDateTime,
                initialDate: curDateTime);
            if (picked != null) {
              setDateTime(picked);
            }
          },
          key: const ValueKey("1"),
          child: Text(
              "${curDateTime.month.toString().padLeft(2, '0')}/${curDateTime.day.toString().padLeft(2, '0')}/${curDateTime.year.toString().padLeft(2, '0')}"),
        ),
        TextButton(
          onPressed: () async {
            final TimeOfDay? picked = await showTimePicker(
                initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                context: context);
            if (picked != null) {
              setDateTime(DateTime(curDateTime.year, curDateTime.month,
                  curDateTime.day, picked.hour, picked.minute));
            }
          },
          key: const ValueKey("2"),
          child: Text(
              "${curDateTime.hour.toString().padLeft(2, '0')}:${curDateTime.minute.toString().padLeft(2, '0')}"),
        ),
      ],
    );
  }
}
*/

import 'dart:convert';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:control_panel/constants.dart';
import 'package:control_panel/views/overview/fridge_overview_display.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class SensorStats extends StatefulWidget {
  final String sensorKey;
  final DateTime timeCalled;
  final bool isCentigrade;
  const SensorStats(
      {Key? key,
      required this.sensorKey,
      required this.timeCalled,
      required this.isCentigrade})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<SensorStats> {
  final Color leftBarColor = const Color(0xffff5182);
  final Color rightBarColor = const Color(0xff53fdd7);
  final double width = 7;

  List<BarChartGroupData> showingBarGroups = [];

  @override
  void initState() {
    super.initState();

    () async {
      
      http.Response r = await http.get(Uri.parse(
          '$remoteHttpDomain/api/v1/get-sensor-stat?sensor-key=${widget.sensorKey}'));
      if (r.statusCode != 200) {
        if (!mounted) {
          return;
        }
        FlushbarHelper.createError(message: "Server Error").show(context);
        Navigator.pop(context);
      }
      var jsonData = json.decode(r.body);
      List<BarChartGroupData> items = [];
      for (int i = jsonData.length - 1; i >= 0; i--) {
        var v = jsonData[i];
        if (v["valid"] == true) {
          items.add(makeGroupData(
              i,
              cToF((v["twentyFifth"] * 100).round().toDouble() / 100.0),
              cToF(v["seventyFifth"] * 100).round().toDouble() / 100.0));
        }
      }

      if (items.isEmpty) {
        if (!mounted) {
          return;
        }
        FlushbarHelper.createError(message: "No data was received")
            .show(context);

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
    if (widget.isCentigrade) {
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
    } else {
      if (value == 0) {
        text = '0° F';
      } else if (value == 5) {
        text = '5° F';
      } else if (value == 10) {
        text = '10° F';
      } else if (value == 15) {
        text = '15° F';
      } else if (value == 20) {
        text = '20° F';
      } else if (value == 25) {
        text = '25° F';
      } else if (value == 30) {
        text = '30° F';
      } else if (value == 35) {
        text = '35° F';
      } else if (value == 40) {
        text = '40° F';
      } else {
        return Container();
      }
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
