import 'package:control_panel/view_model/main_view/fridges/remove_fridge_actions.dart';
import 'package:flutter/material.dart';

class RemoveDialog {
  static void startDialog(BuildContext context, String accessToken,
      String fridgeID, String fridgeName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Fridge'),
            content: Text(
                "Warning, you will now delete fridge '$fridgeName' and all sensors associated with it. Do you want to proceed?'"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, ''),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (await removeButton(accessToken, fridgeID) == false) {
                    const snackBar = SnackBar(
                      content: Text('Error removing fridge'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context, '');
                  } else {
                    Navigator.pop(context, '');
                  }
                },
                child: const Text(
                  'Remove',
                ),
              ),
            ],
          );
        });
  }
}
