import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:control_panel/constants.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class StepperViewModel with ChangeNotifier {
  int _currentStep = 0;
  IconType _displayIcon = IconType.ok;
  IconType get displayIcon => _displayIcon;
  set displayIcon(IconType d) {
    _displayIcon = d;
    notifyListeners();
  }

  String accessToken;
  final GlobalKey<FormState> formKey;
  StepperViewModel({required this.formKey, required this.accessToken});
  set currentStep(int newCurrentStep) {
    _currentStep = newCurrentStep;
    notifyListeners();
  }

  int get currentStep => _currentStep;

  Function()? getOnStepCancel(context) {
    return () {
      Navigator.of(context).pop();
    };
  }

  String? fridgeName;

  Function()? getOnStepContinue(context) {
    if (currentStep != 0) {
      return null;
    } else {
      return () {
        FormState? state = formKey.currentState;
        if (state == null) {
          debugPrint("State has not been set");
          return;
        }
        bool? validated = state.validate();
        if (validated == true) {
          state.save();
          currentStep++;
          () async {
            var body = (await http.post(
                Uri.parse(
                    "$remoteHttpDomain/api/frontend/v2/register-fridge?fridge-name=${Uri.encodeFull(fridgeName ?? "")}"),
                headers: {"Authorization": accessToken}));
            if (body.statusCode != 200) {
              log("add-fridge-error: ${body.statusCode}");
              debugPrint("error: ${body.statusCode} is not 200");
              displayIcon = IconType.error;
              currentStep++;
            } else {
              log('add-fridge-body: ${body.body}');
              var returnMap = jsonDecode(body.body);
              log("add-fridge-returnMap=$returnMap");
              if (returnMap["error-code"] == 0) {
                displayIcon = IconType.ok;
                currentStep++;
                Timer(const Duration(seconds: 1), () {
                  Navigator.of(context).pop();
                });
              } else {
                displayIcon = IconType.error;
                debugPrint("add-fridge-error: ${returnMap["error"]}");
              }
            }
          }();
        }
      };
    }
  }

  void onSave(String? newName) {
    fridgeName = newName;
  }

  Function(int index)? getOnStepTapped() {
    return null;
  }
}

enum IconType { ok, error }
