import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:control_panel/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:http/http.dart' as http;

class RegisterPhoneViewModel with ChangeNotifier {
  String accessToken;
  IconType displayIcon = IconType.ok;
  GlobalKey<FormState> formKey;
  int _currentStep = 0;
  PhoneNumber? _numToRegister;
  PhoneNumber? get numToRegister => _numToRegister;
  set numToRegister(PhoneNumber? numToRegister) {
    _numToRegister = numToRegister;
    notifyListeners();
  }

  int get currentStep => _currentStep;
  set currentStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  RegisterPhoneViewModel({required this.accessToken, required this.formKey});
  void Function()? getOnStepCancel(BuildContext context) {
    return () {
      Navigator.of(context).pop();
    };
  }

  void Function()? getOnStepContinue() {
    switch (currentStep) {
      case 0:
        if (numToRegister == null) {
          return null;
        } else {
          return () {
            currentStep++;
            () async {
              try {
                var body = (await http.post(
                    Uri.parse(
                        "$remoteHttpDomain/api/frontend/v2/register-telephone?phone=${Uri.encodeComponent(numToRegister?.number ?? "")}"),
                    headers: {"Authorization": accessToken}));
                if (body.statusCode != 200) {
                  log("add-fridge-error: ${body.statusCode}");
                  debugPrint("error: ${body.statusCode} is not 200");
                  displayIcon = IconType.error;
                  currentStep = 0;
                } else {
                  currentStep = 2;
                }
              } catch (e) {
                debugPrint("catch: $e");
              }
            }();
          };
        }
      case 1:
        return null;
    }
    return null;
  }

  void onStep1Changed(PhoneNumber? val) {
    FormState? state = formKey.currentState;
    if (state == null) {
      numToRegister = null;
      return;
    }
    if (state.validate()) {
      numToRegister = val;
    } else {
      numToRegister = null;
    }
  }

  void onStep1Saved(PhoneNumber? val) {}

  void onStep2Completed(String text, Function pop) async {
    try {
      var body = (await http.post(
          Uri.parse(
              "$remoteHttpDomain/api/frontend/v2/verify-telephone?phone=${Uri.encodeComponent(numToRegister?.number ?? "")}&code=${Uri.encodeComponent(text)}"),
          headers: {"Authorization": accessToken}));
      if (body.statusCode != 200) {
        log("add-fridge-error: ${body.statusCode}");
        debugPrint("error: ${body.statusCode} is not 200");
        displayIcon = IconType.error;
        currentStep = 0;
      } else {
        var retVal = jsonDecode(body.body);
        log("retval=$retVal");
        if (retVal["error-code"] == 0) {
          currentStep = 3;
          Timer(const Duration(seconds: 1), () {
            pop();
          });
        }
      }
    } catch (e) {
      debugPrint("catch: $e");
    }
  }
}

enum IconType { ok, error }
