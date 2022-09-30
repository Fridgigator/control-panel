import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:http/http.dart' as http;

class AddAlarm extends StatefulWidget {
  final String sensorID;
  const AddAlarm({
    Key? key,
    required this.sensorID,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddAlarmState();
}

class AddAlarmState extends State<AddAlarm> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  bool gotData = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValid = false;
  PhoneNumber number = PhoneNumber();
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
          number = PhoneNumber(phoneNumber: body["phone"]);
          phoneNumberController = TextEditingController(text: body["phone"]);
          temperatureController =
              TextEditingController(text: "${body["tempToAlert"]}");
        }
        gotData = true;
      });
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
                  ? Center(child: CircularProgressIndicator())
                  : Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber value) {
                              number = value;
                            },
                            onInputValidated: (bool value) {
                              setState(() {
                                isValid = value &&
                                    temperatureController.text.isNotEmpty;
                              });
                            },
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.always,
                            selectorTextStyle: TextStyle(color: Colors.white),
                            initialValue: PhoneNumber(isoCode: 'US'),
                            textFieldController: phoneNumberController,
                            formatInput: true,
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: OutlineInputBorder(),
                            onSaved: (PhoneNumber number) {},
                          ),
                          TextFormField(
                            onChanged: (v) {
                              setState(() {
                                isValid = (formKey.currentState?.validate() ??
                                        false) &&
                                    temperatureController.text.isNotEmpty;
                              });
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: temperatureController,
                            decoration: const InputDecoration(
                              hintText:
                                  "Enter Temperature to Alert (in Centigrade)",
                              helperText: "°C",
                            ),
                          ),
                          MaterialButton(
                              onPressed: isValid
                                  ? () async {
                                      await http.get(
                                        Uri.parse(
                                            'https://fridgigator.herokuapp.com/api/add-alarm?sensorID=${widget.sensorID}&phone=${Uri.encodeComponent(number.phoneNumber ?? "")}&temp=${temperatureController.text}'),
                                      );
                                      if (!mounted) return;
                                      Navigator.pop(context);
                                    }
                                  : null,
                              child: const Text("Submit"))
                        ],
                      ))),
          title: const Text("Set Alarm"),
        ),
      ),
    );
  }
}
