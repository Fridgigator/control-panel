import 'package:control_panel/views/fridges/add_fridge/stepper.dart';
import 'package:flutter/material.dart';

class AddDialog {
  static void startDialog(BuildContext context, String accessToken) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Fridge'),
            content: AddStepper(accessToken: accessToken),
          );
        });
  }
}
