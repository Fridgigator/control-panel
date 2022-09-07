import 'package:flutter/material.dart';

class AddSensor extends StatefulWidget {
  final String accessToken;
  const AddSensor({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddSensorState();
}

class AddSensorState extends State<AddSensor> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Sensor"));
  }
}
