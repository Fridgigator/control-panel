import 'package:control_panel/structures/data_types.dart';
import 'package:control_panel/views/dialog_box/add_alarm.dart';
import 'package:control_panel/views/dialog_box/view_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class FrontPage extends StatefulWidget {
  const FrontPage(
      {required this.accessCode,
      Key? key,
      required this.fridges,
      required this.loggedIn,
      required this.remoteName,
      required this.hubs})
      : super(key: key);
  final String? accessCode;
  final List<Fridge> fridges;
  final List<Hub> hubs;
  final String? remoteName;
  final bool loggedIn;

  @override
  State<FrontPage> createState() => _MyFrontPageState();
}

class _MyFrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    widget.hubs.sort((Hub a, Hub b) => a.uuid.compareTo(b.uuid));
    Widget child;
    if (widget.accessCode == null) {
      if (!widget.loggedIn) {
        child = const Text("Please log in");
      } else {
        child = const LinearProgressIndicator();
      }
    } else {
      if (widget.remoteName == null) {
        child = const LinearProgressIndicator();
      } else {
        child = LayoutBuilder(builder: (context, constraints) {
          List<Widget> rows = [];
          rows.addAll([
            Row(children: [Text("Welcome ${widget.remoteName}:")]),
          ]);
          rows.add(Row(
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                    child: DataTable(
                        columns: const [
                          DataColumn(label: Text("UUID")),
                          DataColumn(label: Text("Connected")),
                          DataColumn(label: Text("Remove")),
                        ],
                        rows: widget.hubs
                            .map((e) => DataRow(cells: [
                                  DataCell(Text(e.uuid)),
                                  DataCell(e.isConnected
                                      ? const Icon(Icons.circle,
                                          color: Colors.green)
                                      : const Icon(Icons.circle,
                                          color: Colors.red)),
                                  DataCell(IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        deleteHub(e.uuid);
                                      })),
                                ]))
                            .toList()),
                  ))
            ],
          ));
          rows.add(Row(children: [Expanded(child: Divider())]));
          for (Fridge fridge in widget.fridges) {
            rows.add(Row(children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Row(children: [
                    Text("Fridge ${fridge.name}:"),
                    IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          deleteFridge(fridge.uuid);
                        })
                  ]))
            ]));

            rows.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child: DataTable(
                            columns: const [
                              DataColumn(label: Text("Location")),
                              DataColumn(label: Text("Sensor")),
                              DataColumn(label: Text("")),
                              DataColumn(label: Text("")),
                              DataColumn(label: Text("")),
                              DataColumn(label: Text("Last Seen")),
                              DataColumn(label: Text("")),
                              DataColumn(label: Text("")),
                              DataColumn(label: Text("")),
                            ],
                            rows: fridge.sensors.map((e) {
                              String text = "";
                              switch (e.typeOfData) {
                                case 1:
                                  text = "Temperature: ";
                                  break;
                                case 2:
                                  text = "Humidity: ";
                                  break;
                              }
                              return DataRow(cells: [
                                DataCell(Text(e.location)),
                                DataCell(Text(e.uuid)),
                                DataCell(Text(e.model)),
                                DataCell(Text(text)),
                                DataCell(Text((e.value != -62135596800)
                                    ? "${e.value}"
                                    : "None")),
                                DataCell(Text((e.time != -62135596800)
                                    ? timeago.format(
                                        DateTime.fromMicrosecondsSinceEpoch(
                                                ((e.time ?? 0) * 1000 * 1000)
                                                    .toInt(),
                                                isUtc: true)
                                            .toLocal())
                                    : "Never")),
                                DataCell(IconButton(
                                    icon: const Icon(Icons.auto_graph_rounded),
                                    onPressed: () {
                                      startPopup(ViewData(
                                          sensorID: e.uuid,
                                          timeCalled: DateTime.now()));
                                    })),
                                DataCell(IconButton(
                                    icon: const Icon(Icons.alarm),
                                    onPressed: () {
                                      startPopup(AddAlarm(
                                        sensorID: e.uuid,
                                        accessToken: widget.accessCode ?? "",
                                      ));
                                    })),
                                DataCell(IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      deleteSensor(e.uuid);
                                    }))
                              ]);
                            }).toList()))),
              ],
            ));
          }

          return SingleChildScrollView(child: Column(children: rows));
        });
      }
    }
    return Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 8), child: child);
  }

  void deleteSensor(String uuid) async {
    await http.get(Uri.parse(
        'https://fridgigator.herokuapp.com/api/delete?type=sensor&uuid=$uuid'));
  }

  void deleteHub(String uuid) async {
    await http.get(Uri.parse(
        'https://fridgigator.herokuapp.com/api/delete?type=hub&uuid=$uuid'));
  }

  void deleteFridge(String uuid) async {
    await http.get(Uri.parse(
        'https://fridgigator.herokuapp.com/api/delete?type=fridge&uuid=$uuid'));
  }

  Future<Object?> startPopup(Widget widget) async {
    Object? a = await showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "Barrier",
        barrierColor: Colors.grey.withOpacity(0.5),
        context: context,
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) {
          return StatefulBuilder(builder: (context, setState) {
            return widget;
          });
        },
        transitionBuilder: (_, anim, __, child) {
          Tween<Offset> tween;
          if (anim.status == AnimationStatus.reverse) {
            tween = Tween(begin: const Offset(0, 11), end: Offset.zero);
          } else {
            tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
          }

          return SlideTransition(
            position: tween.animate(anim),
            child: FadeTransition(
              opacity: anim,
              child: child,
            ),
          );
        });
    return a;
  }
}
