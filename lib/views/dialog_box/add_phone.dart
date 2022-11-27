import 'dart:convert';

import 'package:control_panel/structures/data_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

class PhoneSettings extends StatefulWidget {
  final String accessToken;
  const PhoneSettings({
    Key? key,
    required this.accessToken,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhoneSettingsStatefulWidget();
}

class PhoneSettingsStatefulWidget extends State<PhoneSettings> {
  PhoneNumber number = PhoneNumber();
  bool isValid = false;
  PhoneState state = PhoneState.loading;
  List<PhoneData> d = [];
  TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String currentText = "";
  TextEditingController textEditingController = TextEditingController();
  String phoneToVerify = "";

  @override
  void initState() {
    super.initState();
    () async {
      http.Response r = await http.post(
          Uri.parse(
              'https://fridgigator-001.fly.dev/api/v1/get-telephone-list'),
          headers: <String, String>{'Authorization': widget.accessToken});
      List<dynamic> phone = jsonDecode(r.body);
      debugPrint(r.body);
      setState(() {
        d = phone.map((e) {
          VerifiedState verifiedState;
          if (e["verified"] == 0) {
            verifiedState = VerifiedState.verified;
          } else if (e["verified"] == 1) {
            verifiedState = VerifiedState.expired;
          } else {
            verifiedState = VerifiedState.notVerified;
          }

          return PhoneData(num: e["phone"], state: verifiedState);
        }).toList();
        state = PhoneState.view;
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
        title: getTitle(state),
        content: SizedBox(
          height: 480,
          width: 480,
          child: getView(state),
        ),
      ),
    ));
  }

  Widget getView(PhoneState curState) {
    var num = number.phoneNumber;
    switch (curState) {
      case PhoneState.view:
        var dataRows = d.map((data) {
          return DataRow(cells: [
            DataCell(IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            )),
            DataCell(Text(data.num)),
            DataCell(GetVerifiedWidget(data.state, data.num))
          ]);
        }).toList();
        dataRows.add(DataRow(cells: [
          DataCell(Text("")),
          DataCell(TextButton(
              onPressed: () {
                setState(() {
                  state = PhoneState.add;
                });
              },
              child: Text("Add"))),
          DataCell(Text("")),
        ]));
        return DataTable(columns: [
          DataColumn(label: Text("")),
          DataColumn(label: Text("")),
          DataColumn(label: Text(""))
        ], rows: dataRows);
      case PhoneState.add:
        return Form(
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
                      isValid = value;
                    });
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.always,
                  selectorTextStyle: const TextStyle(color: Colors.white),
                  initialValue: PhoneNumber(isoCode: 'US'),
                  textFieldController: phoneNumberController,
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: const OutlineInputBorder(),
                  onSaved: (PhoneNumber number) {},
                ),
                MaterialButton(
                    onPressed: num != null
                        ? () async {
                            await http.post(
                                Uri.parse(
                                  'https://fridgigator-001.fly.dev/api/v1/register-telephone?phone=${Uri.encodeComponent(num)}',
                                ),
                                headers: <String, String>{
                                  'Authorization': widget.accessToken
                                });
                            setState(() {
                              phoneToVerify = num;
                              state = PhoneState.verify;
                            });
                          }
                        : null,
                    child: const Text("Submit"))
              ],
            ));
      case PhoneState.verify:
        return Center(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text("Enter confirmation code:")),
          PinCodeTextField(
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
            ),
            animationDuration: Duration(milliseconds: 300),
            controller: textEditingController,
            onCompleted: (v) async {
              var r = await http.post(
                  Uri.parse(
                    'https://fridgigator-001.fly.dev/api/v1/verify-phone?phone=${Uri.encodeComponent(phoneToVerify)}&code=${Uri.encodeComponent(v)}',
                  ),
                  headers: <String, String>{
                    'Authorization': widget.accessToken
                  });
              dynamic phone = jsonDecode(r.body);
              if (phone["correct"] == "true") {
                if (!mounted) return;
                Navigator.pop(context);
              } else if (phone["correct"] == "false") {
                const snackBar = SnackBar(
                  content: Text('Code was incorrect'),
                );
                if (!mounted) {
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (phone["correct"] == "timeout") {
                const snackBar = SnackBar(
                  content: Text('Timeout'),
                );
                if (!mounted) {
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            onChanged: (value) {
              print(value);
              setState(() {
                currentText = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
            appContext: context,
          ),
          TextButton(child: Text("Resend"), onPressed: () {}),
        ]));
      case PhoneState.loading:
        return const Center(child: CircularProgressIndicator());
    }
  }

  Widget getTitle(PhoneState curState) {
    switch (curState) {
      case PhoneState.loading:
        return Text("Loading Phones");
      case PhoneState.view:
        return Text("Phones");
      case PhoneState.add:
        return Text("Add Phones");
      case PhoneState.verify:
        return Text("Verify Phone");
    }
  }

  Widget GetVerifiedWidget(VerifiedState d, String phone) {
    switch (d) {
      case VerifiedState.expired:
        return Text("Expired", style: TextStyle(color: Colors.red));
      case VerifiedState.verified:
        return Text("Verified", style: TextStyle(color: Colors.green));
      case VerifiedState.notVerified:
        return TextButton(
            child: Text("Verify"),
            onPressed: () {
              setState(() {
                phoneToVerify = phone;
                state = PhoneState.verify;
              });
            });
    }
  }
}

enum PhoneState { loading, view, add, verify }
