import 'package:control_panel/views/phone/register_stepper.dart';
import 'package:flutter/material.dart';

class RegisterPhone {
  static void startDialog(
      BuildContext context, String accessToken, bool smallScreen) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Register Phone'),
            content: RegisterPhoneStepper(
              accessToken: accessToken,
              smallScreen: smallScreen,
            ),
          );
        });
  }

  static Widget replaceMain(String accessToken, bool smallScreen) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Phone')),
      body: RegisterPhoneStepper(
          accessToken: accessToken, smallScreen: smallScreen),
    );
  }
}
