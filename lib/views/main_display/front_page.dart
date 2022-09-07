import 'package:control_panel/structures/data_types.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatefulWidget {
  const FrontPage(
      {required this.accessCode,
      Key? key,
      required this.fridges,
      required this.loggedIn,
      required this.remoteName,
      required this.hubs})
      : super(key: key);
  final String accessCode;
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
    return Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: LayoutBuilder(builder: (context, constraints) {
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
                          DataColumn(label: Text("uuid")),
                          DataColumn(label: Text("Settings"))
                        ],
                        rows: widget.hubs
                            .map((e) => DataRow(cells: [
                                  DataCell(Text(e.uuid)),
                                  DataCell(DropdownButton(
                                    value: "B",
                                    onChanged: (e) {},
                                    items: const [
                                      DropdownMenuItem(
                                          value: "A", child: Text("A")),
                                      DropdownMenuItem(
                                        value: "B",
                                        child: Text(""),
                                      )
                                    ],
                                  ))
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
                  child: Text("Fridge ${fridge.name}:"))
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
                              DataColumn(label: Text("Sensor")),
                              DataColumn(label: Text("uuid")),
                              DataColumn(label: Text("model")),
                              DataColumn(label: Text("Temperature")),
                              DataColumn(label: Text("Humidity")),
                              DataColumn(label: Text("Settings"))
                            ],
                            rows: fridge.sensors
                                .map((e) => DataRow(cells: [
                                      DataCell(Text(e.name)),
                                      DataCell(Text(e.uuid)),
                                      DataCell(Text(e.model)),
                                      DataCell(Text("${e.value[0]}")),
                                      DataCell(Text("${e.value[1]}")),
                                      DataCell(DropdownButton(
                                        value: "B",
                                        onChanged: (e) {},
                                        items: const [
                                          DropdownMenuItem(
                                              value: "A", child: Text("A")),
                                          DropdownMenuItem(
                                            value: "B",
                                            child: Text(""),
                                          )
                                        ],
                                      ))
                                    ]))
                                .toList()))),
              ],
            ));
          }

          if (widget.remoteName == null) {
            if (!widget.loggedIn) {
              return const Text("Please log in");
            } else {
              return const LinearProgressIndicator();
            }
          } else {
            return SingleChildScrollView(child: Column(children: rows));
          }
        }));
  }
}
