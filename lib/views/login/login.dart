import 'dart:convert';

import 'package:control_panel/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold(
      {super.key, required this.darkTheme, required this.onLogin});
  final bool darkTheme;
  final Function(String accessToken) onLogin;

  Future<String?> _authUser(LoginData data) async {
    try {
      var body = (await http
          .post(Uri.parse("$remoteHttpDomain/login/v1/email/signin"), body: {
        "email": data.name,
        "password": data.password,
      }));
      if (body.statusCode != 200) {
        debugPrint("${body.statusCode}");
        throw "Backend Error";
      }
      var returnMap = jsonDecode(body.body);
      if (returnMap["error-code"] == 0) {
        debugPrint("$returnMap");
        onLogin(returnMap["access-token"]);
        return '';
      } else {
        return returnMap["error-output"];
      }
    } catch (e) {
      debugPrint("$e");
      return 'Error: $e';
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      var body = (await http
          .post(Uri.parse("$remoteHttpDomain/login/v1/email/signup"), body: {
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

  Future<String?> _recoverPassword(String name) async {
    try {
      var body = (await http
          .post(Uri.parse("$remoteHttpDomain/login/v1/email/recover"), body: {
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

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Fridgigator',
      logo: const Svg('assets/assets/fridge.svg'),
      loginProviders: [
        LoginProvider(
            icon: FontAwesomeIcons.github,
            callback: () {
              return null;
            })
      ],
      passwordValidator: (String? passwd) {
        if (passwd == null || passwd.length < 6) {
          return "Password should be at least 6 characters";
        } else {
          return null;
        }
      },
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyApp(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
