import 'dart:convert';
import 'dart:developer';

import 'package:control_panel/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

Future<bool> removeButton(String accessToken, String fridgeID) async {
  var body = (await http.post(
      Uri.parse(
          "$remoteHttpDomain/api/frontend/v2/remove-fridge?fridge-id=${Uri.encodeFull(fridgeID)}"),
      headers: {"Authorization": accessToken}));
  if (body.statusCode != 200) {
    debugPrint("remove-fridge-error: ${body.statusCode}");
    debugPrint("error: ${body.statusCode} is not 200");
    return false;
  } else {
    log('remove-fridge-body: ${body.body}');
    var returnMap = jsonDecode(body.body);
    log("remove-fridge-returnMap=$returnMap");
    if (returnMap["error-code"] == 0) {
      return true;
    } else {
      debugPrint("add-fridge-error: ${returnMap["error"]}");
      return false;
    }
  }
}
