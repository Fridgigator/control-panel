import 'package:flutter/material.dart';

import '../../../structures/data_types.dart';
import '../add_sensor.dart';

class SelectSensor extends StatefulWidget {
  final String name;
  final String address;
  final Function(SensorMaker maker) onAdd;
  final Function() onSensorTap;
  final bool shouldDisplaySensorType;
  final List<Fridge> fridges;
  const SelectSensor(
      {Key? key,
      required this.address,
      required this.name,
      required this.onSensorTap,
      required this.shouldDisplaySensorType,
      required this.fridges,
      required this.onAdd})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectSensorState();
}

class _SelectSensorState extends State<SelectSensor> {
  SensorMaker sMaker = SensorMaker.None;
  Fridge? selectedFridge;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(
        widget.name,
        textAlign: TextAlign.start,
        overflow: TextOverflow.clip,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
        ),
      )
    ];
    List<DropdownMenuItem<Fridge>> fridgeMenuItems =
        widget.fridges.map((Fridge e) {
      return DropdownMenuItem(value: e, child: Text(e.name));
    }).toList();
    if (widget.shouldDisplaySensorType) {
      children.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
                width: 375,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton(
                        value: sMaker,
                        onChanged: (SensorMaker? e) {
                          if (e != null) {
                            setState(() {
                              sMaker = e;
                            });
                          }
                        },
                        items: const [
                          DropdownMenuItem(
                              value: SensorMaker.None,
                              child: Text("Select Sensor Type")),
                          DropdownMenuItem(
                              value: SensorMaker.TI, child: Text("TI")),
                          DropdownMenuItem(
                              value: SensorMaker.Nordic, child: Text("Nordic")),
                          DropdownMenuItem(
                              value: SensorMaker.Custom, child: Text("Custom")),
                        ]),
                    TextField(
                      controller: null,
                      decoration: const InputDecoration(
                        hintText: "Enter Location in Fridge",
                        helperText: "Location",
                      ),
                    ),
                    DropdownButton(
                        value: selectedFridge,
                        onChanged: (Fridge? e) {
                          setState(() {
                            selectedFridge = e;
                          });
                        },
                        items: fridgeMenuItems)
                  ],
                )),
            MaterialButton(
                child: const Text("Add"),
                onPressed: () {
                  debugPrint(sMaker.name);
                  if (sMaker != SensorMaker.None) {
                    debugPrint("about to run onadd");
                    widget.onAdd(sMaker);
                  }
                }),
          ]));
    }
    return InkWell(
        onTap: widget.shouldDisplaySensorType
            ? null
            : () {
                widget.onSensorTap();
              },
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: children,
                  )
                ])));
  }
}
