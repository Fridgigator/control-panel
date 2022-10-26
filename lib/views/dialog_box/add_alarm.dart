import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../structures/data_types.dart';

class AddAlarm extends StatefulWidget {
  final String sensorID;
  final String accessToken;
  const AddAlarm({Key? key, required this.sensorID, required this.accessToken})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => AddAlarmState();
}

class AddAlarmState extends State<AddAlarm> {
  TextEditingController temperatureController = TextEditingController();
  bool gotData = false;
  bool isValid = false;
  List<PhoneData> d = [];
  String unitMeasure = 'C';
  String telephoneToAlert = "None";
  @override
  void initState() {
    super.initState();
    () async {
      http.Response r = await http.get(
        Uri.parse(
            'https://fridgigator.herokuapp.com/api/get-alarm?sensorID=${widget.sensorID}'),
      );
      var body = jsonDecode(r.body);
      setState(() {
        if (body["phone"] != "") {
          temperatureController =
              TextEditingController(text: "${body["tempToAlert"]}");
          telephoneToAlert = body["phone"];
        }
        isValid = isDouble(temperatureController.text);
      });
      r = await http.post(
          Uri.parse(
              'https://fridgigator.herokuapp.com/api/v1/get-telephone-list'),
          headers: <String, String>{'Authorization': widget.accessToken});
      List<dynamic> phone = jsonDecode(r.body);
      setState(() {
        d = phone.where((e) => e["verified"] == 0).map((e) {
          return PhoneData(num: e["phone"], state: VerifiedState.verified);
        }).toList();
      });
      gotData = true;
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 480,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: AlertDialog(
          content: SizedBox(
              height: 480,
              width: 480,
              child: !gotData
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Alert"),
                        DropdownButton(
                            value: telephoneToAlert,
                            items: [
                              const DropdownMenuItem(
                                value: "None",
                                child: Text("None"),
                              ),
                              ...d
                                  .map((e) => DropdownMenuItem(
                                      value: e.num, child: Text(e.num)))
                                  .toList()
                            ],
                            onChanged: (String? n) {
                              if (n != null) {
                                setState(() {
                                  telephoneToAlert = n;
                                });
                              }
                            }),
                        const Text("when above"),
                        SizedBox(
                            width: 36,
                            child: TextField(
                              decoration: InputDecoration(
                                errorText: !(isValid ||
                                        temperatureController.text == "")
                                    ? ""
                                    : null,
                              ),
                              controller: temperatureController,
                              onChanged: (v) {
                                setState(() {
                                  isValid = isDouble(v);
                                });
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                            )),
                        DropdownButton(
                            value: unitMeasure,
                            items: const [
                              DropdownMenuItem(value: 'F', child: Text("°F")),
                              DropdownMenuItem(value: 'C', child: Text("°C"))
                            ],
                            onChanged: (String? n) {
                              if (n != null) {
                                setState(() {
                                  unitMeasure = n;
                                });
                              }
                            }),
                        MaterialButton(
                            onPressed: isValid
                                ? () async {
                                    double? tInC = double.tryParse(
                                        temperatureController.text);
                                    if (unitMeasure == "F" && tInC != null) {
                                      tInC = (tInC - 32.0) * (5.0 / 9.0);
                                    }
                                    if (tInC != null) {
                                      if (telephoneToAlert != "None") {
                                        await http.get(
                                          Uri.parse(
                                              'https://fridgigator.herokuapp.com/api/v1/add-alarm?sensorID=${widget.sensorID}&phone=${Uri.encodeComponent(telephoneToAlert)}&temp=$tInC'),
                                        );
                                      } else {
                                        debugPrint("not null");
                                        await http.get(
                                          Uri.parse(
                                              'https://fridgigator.herokuapp.com/api/v1/delete-alarm?sensorID=${widget.sensorID}'),
                                        );
                                      }
                                    }
                                    if (!mounted) return;
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: const Text("Confirm"))
                      ],
                    )),
          title: const Text("Set Alarm"),
        ),
      ),
    );
  }
}

bool isDouble(String v) {
  return double.tryParse(v) != null;
}
