import 'dart:convert';

import 'package:control_panel/structures/data_types.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

import 'add_hub_views/select_sensor.dart';

class AddSensor extends StatefulWidget {
  final String accessToken;
  final List<Fridge> fridges;
  const AddSensor({
    Key? key,
    required this.accessToken,
    required this.fridges,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddSensorState();
}

class AddSensorState extends State<AddSensor> {
  SensorState curState = SensorState.initialState;
  List<_Sensor> availableSensors = [];
  int? currentlySelected;
  SensorMaker maker = SensorMaker.None;
  String sensorName = "";
  String sensorAddress = "";
  String fridgeID = "";
  @override
  void initState() {
    super.initState();
    final channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://fridgigator-001.fly.dev/api/get-add-sensor-results?accessToken=${widget.accessToken}'),
    );
    availableSensors.clear();
    channel.stream.handleError((e) => debugPrint("error=$e"));
    channel.stream.listen((event) async {
      if (curState == SensorState.initialState ||
          curState == SensorState.selectSensors) {
        var data = jsonDecode(event);
        List<Sensor> sensors = [];
        for (Fridge f in widget.fridges) {
          sensors.addAll(f.sensors);
        }
        if (!mounted) return;
        if (data != null) {
          bool found = false;
          setState(() {
            data.forEach((key, value) {
              curState = SensorState.selectSensors;
              if (!sensors.map((k) => k.uuid).contains(key)) {
                found = true;
                debugPrint("|key=$key|,name=$value|");
                if ("$value" != "") {
                  availableSensors
                      .add(_Sensor(address: key, name: value, fridgeID: ""));
                }
              }
            });
          });

          if (!found && mounted) {
            setState(() {
              curState = SensorState.noValidDevices;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 480,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: AlertDialog(
          content: SizedBox(height: 480, width: 480, child: getView(curState)),
          title: getTitle(curState),
        ),
      ),
    );
  }

  Widget getView(SensorState curState) {
    switch (curState) {
      case SensorState.initialState:
        return const Center(child: CircularProgressIndicator());
      case SensorState.selectSensors:
        return Center(
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: availableSensors
                        .mapIndexed((index, e) => SelectSensor(
                              key: ValueKey(e),
                              address: e.address,
                              name: e.name,
                              fridges: widget.fridges,
                              onSensorTap: () {
                                setState(() {
                                  currentlySelected = index;
                                });
                              },
                              shouldDisplaySensorType:
                                  currentlySelected != null &&
                                      currentlySelected == index,
                              onAdd: (SensorMaker maker, String fridgeID,
                                  String location) {
                                setState(() {
                                  this.maker = maker;
                                  this.curState = SensorState.sendingData;
                                  sensorName = e.name;
                                  sensorAddress = e.address;
                                  this.fridgeID = fridgeID;
                                });
                                () async {
                                  http.Response r = await http.post(
                                      Uri.parse(
                                          'https://fridgigator-001.fly.dev/api/finalize-add-sensor'),
                                      headers: <String, String>{
                                        'Authorization': widget.accessToken
                                      },
                                      body: json.encode({
                                        "maker": this.maker.name,
                                        "name": sensorName,
                                        "address": sensorAddress,
                                        "location": location,
                                        "fridgeID": fridgeID,
                                      }));
                                  if (r.statusCode != 200) {
                                    setState(() {
                                      this.curState =
                                          SensorState.errorSendingData;
                                    });
                                  }
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                }();
                              },
                            ))
                        .toList())));
      case SensorState.sendingData:
        return const Center(child: CircularProgressIndicator());
      case SensorState.errorSendingData:
        return const Text("Couldn't add sensor");
      case SensorState.noValidDevices:
        return const Text(
            "Cannot find a new device to add. Try removing one from an existing fridge.");
    }
  }

  Widget getTitle(SensorState curState) {
    switch (curState) {
      case SensorState.initialState:
        return const Text("Getting Sensor List");
      case SensorState.selectSensors:
        return const Text("Select Sensor");
      case SensorState.sendingData:
        return const Text("Sending Data");
      case SensorState.errorSendingData:
        return const Text("Error");
      case SensorState.noValidDevices:
        return const Text("Error");
    }
  }
}

class _Sensor {
  String name;
  String address;
  String fridgeID;
  _Sensor({required this.address, required this.name, required this.fridgeID});
}

enum SensorState {
  initialState,
  selectSensors,
  sendingData,
  errorSendingData,
  noValidDevices,
}

enum SensorMaker {
  TI,
  Nordic,
  Custom,
  None,
}
