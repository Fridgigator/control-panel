import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddFridge extends StatefulWidget {
  final String accessToken;
  const AddFridge({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddFridgeState();
}

class _AddFridgeState extends State<AddFridge> {
  FridgeState curState = FridgeState.typeNameOfFridge;
  TextEditingController fridgeNameController = TextEditingController();
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

  Widget getView(FridgeState fs) {
    switch (fs) {
      case FridgeState.typeNameOfFridge:
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: TextField(
            controller: fridgeNameController,
          )),
          MaterialButton(
            child: const Text("Next"),
            onPressed: () async {
              setState(() {
                curState = FridgeState.addingFridge;
              });
              var returnResult = await registerFridge(
                  widget.accessToken, fridgeNameController.text);
              if (returnResult == null) {
                setState(() {
                  Navigator.pop(context);
                });
              } else if (returnResult == FridgeError.nameAlreadyExists) {
                setState(() {
                  curState = FridgeState.nameAlreadyExistsError;
                });
              } else if (returnResult == FridgeError.connectionError) {
                setState(() {
                  curState = FridgeState.connectionError;
                });
              }
            },
          )
        ]);
      case FridgeState.addingFridge:
        return const Center(child: CircularProgressIndicator());
      case FridgeState.nameAlreadyExistsError:
        return const Text("This Fridge name already is in use");
      case FridgeState.connectionError:
        return const Text("Cannot connect");
    }
  }

  Widget getTitle(FridgeState fs) {
    switch (fs) {
      case FridgeState.typeNameOfFridge:
        return const Text("Please Type the Fridge Name");
      case FridgeState.addingFridge:
        return const Text("Adding Fridge");
      case FridgeState.nameAlreadyExistsError:
        return const Text("Error");
      case FridgeState.connectionError:
        return const Text("Error");
    }
  }

  Future<FridgeError?> registerFridge(
      String accessCode, String fridgeName) async {
    dynamic returnVal;
    try {
      http.Response r = await http.post(
          Uri.https('fridgigator-001.fly.dev', '/api/register-fridge',
              {'fridge-name': fridgeName}),
          headers: <String, String>{'Authorization': accessCode});
      returnVal = jsonDecode(r.body);
    } catch (e) {
      return FridgeError.connectionError;
    }
    if (returnVal["error"] == "nameAlreadyExists") {
      return FridgeError.nameAlreadyExists;
    }
    return null;
  }
}

enum FridgeError {
  connectionError,
  nameAlreadyExists,
}

enum FridgeState {
  typeNameOfFridge,
  addingFridge,
  nameAlreadyExistsError,
  connectionError,
}
