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

  @override
  void initState() {
    super.initState();
    final channel = WebSocketChannel.connect(
      Uri.parse(
          'wss://fridgigator.herokuapp.com/api/get-add-sensor-results?accessToken=${widget.accessToken}'),
    );
    availableSensors.clear();
    channel.stream.handleError((e) => debugPrint("error=$e"));
    channel.stream.listen((event) async {
      debugPrint("event=$event");
      if (curState == SensorState.initialState ||
          curState == SensorState.selectSensors) {
        var data = jsonDecode(event);
        data.forEach((key, value) {
          debugPrint("value = $value; mounted=$mounted");
          if (value != "" && mounted) {
            setState(() {
              debugPrint("Setting State selectSensors");
              curState = SensorState.selectSensors;
              availableSensors.add(_Sensor(address: key, name: value));
            });
          }
        });
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
    debugPrint("$maker");
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
                              onAdd: (SensorMaker maker) {
                                setState(() {
                                  debugPrint("Setting State");
                                  this.maker = maker;
                                  this.curState = SensorState.sendingData;
                                  sensorName = e.name;
                                  sensorAddress = e.address;
                                });
                                () async {
                                  http.Response r = await http.post(
                                      Uri.parse(
                                          'https://fridgigator.herokuapp.com/api/finalize-add-sensor'),
                                      headers: <String, String>{
                                        'Authorization': widget.accessToken
                                      },
                                      body: {
                                        "maker": this.maker.name,
                                        "name": sensorName,
                                        "address": sensorAddress,
                                      });
                                  if (r.statusCode != 200) {
                                    setState(() {
                                      this.curState =
                                          SensorState.errorSendingData;
                                    });
                                  }
                                  debugPrint(r.body);
                                }();
                              },
                            ))
                        .toList())));
      case SensorState.sendingData:
        return const Center(child: CircularProgressIndicator());
      case SensorState.errorSendingData:
        return const Text("Couldn't add sensor");
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
    }
  }
}

class _Sensor {
  String name;
  String address;
  _Sensor({required this.address, required this.name});
}

enum SensorState {
  initialState,
  selectSensors,
  sendingData,
  errorSendingData,
}

enum SensorMaker {
  TI,
  Nordic,
  Custom,
  None,
}
