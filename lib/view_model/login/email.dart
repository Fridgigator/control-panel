import 'dart:convert';
import 'dart:developer';

import 'package:control_panel/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmailViewModel with ChangeNotifier {
  String? _accessToken;

  String? get accessToken => _accessToken;
  set accessToken(String? accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }

  Future<String?> authUser(LoginData data) async {
    try {
      var body = (await http.post(
          Uri.parse("$remoteHttpDomain/api/login/v1/email/signin"),
          body: {
            "email": data.name,
            "password": data.password,
          }));
      if (body.statusCode != 200) {
        log("${body.statusCode}");
        throw "Backend Error";
      }
      var returnMap = jsonDecode(body.body);
      if (returnMap["error-code"] == 0) {
        log("$returnMap");
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("accessToken", returnMap['access-token']);
        return null;
      } else {
        return returnMap["error-output"];
      }
    } catch (e) {
      log("$e");
      return 'Error: $e';
    }
  }

  Future<String?> signupUser(SignupData data) async {
    try {
      var body = (await http.post(
          Uri.parse("$remoteHttpDomain/api/login/v1/email/signup"),
          body: {
            "email": data.name,
            "password": data.password,
          }));
      if (body.statusCode != 200) {
        throw "Backend Error";
      }
      var returnMap = jsonDecode(body.body);
      if (returnMap["error-code"] == 0) {
        return '';
      } else {
        return returnMap["error-output"];
      }
    } catch (e) {
      debugPrint("$e");
      return 'Error: $e';
    }
  }

  Future<String?> recoverPassword(String name) async {
    try {
      var body = (await http.post(
          Uri.parse("$remoteHttpDomain/api/login/v1/email/recover"),
          body: {
            "email": name,
          }));
      if (body.statusCode != 200) {
        throw "Backend Error";
      }
      var returnMap = jsonDecode(body.body);
      if (returnMap["error-code"] == 0) {
        return null;
      } else {
        return returnMap["error-output"];
      }
    } catch (e) {
      debugPrint("$e");
      return 'Error: $e';
    }
  }
}
