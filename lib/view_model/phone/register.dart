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
  List<String>? _registeredTelephones;
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

  List<String>? get registeredTelephones => _registeredTelephones;
  set registeredTelephones(List<String>? newPhones) {
    _registeredTelephones = newPhones;
    notifyListeners();
  }

  RegisterPhoneViewModel(
      {required this.accessToken,
      required this.formKey,
      required Function(String display) pop}) {
    getPhoneList(pop);
  }

  void getPhoneList(Function(String display) pop) async {
    try {
      var body = (await http.post(
          Uri.parse("$remoteHttpDomain/api/frontend/v2/get-telephone-list"),
          headers: {"Authorization": accessToken}));
      if (body.statusCode != 200) {
        log("get-telephone-list-error: ${body.statusCode}");
        debugPrint("error: ${body.statusCode} is not 200");
        registeredTelephones = [];
        pop("Server Error");
      } else {
        var retVal = jsonDecode(body.body);
        log("retval=$retVal");
        if (retVal["error-code"] != 0) {
          pop("Server Error");
          debugPrint("$retVal");
        } else {
          if (retVal["phone-list"] == null) {
            registeredTelephones = [];
          } else {
            registeredTelephones = (retVal["phone-list"] as List<dynamic>)
                .map((e) => e.toString())
                .toList();
          }
        }
      }
    } catch (e, stack) {
      debugPrint("catch: $e $stack");
      pop("Server Error");
    }
  }

  void Function()? getOnStepCancel(BuildContext context) {
    return () {
      Navigator.of(context).pop();
    };
  }

  void Function()? getOnStepContinue(Function(String) displaySnackbar) {
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
                displaySnackbar("Server Error");
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

  void onStep1Changed(
      PhoneNumber? val, Function(String display) displaySnackbar) {
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

  void onStep2Completed(
      String text, Function pop, Function(String) displaySnackbar) async {
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
        } else if (retVal["error-code"] == 1) {
          displaySnackbar(
            "Invalid code",
          );
        }
      }
    } catch (e) {
      debugPrint("catch: $e");
    }
  }

  void removePhone(String phone, Function(String) showPopup) async {
    try {
      var body = (await http.post(
          Uri.parse(
              "$remoteHttpDomain/api/frontend/v2/remove-telephone?phone=${Uri.encodeComponent(phone)}"),
          headers: {"Authorization": accessToken}));
      if (body.statusCode != 200) {
        showPopup("Server error");
      } else {
        registeredTelephones = null;
        getPhoneList(showPopup);
      }
    } catch (e, stack) {
      debugPrint("catch: $e $stack");
    }
  }
}

enum IconType { ok, error }
