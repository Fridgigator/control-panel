import 'dart:convert';
import 'dart:developer';

import 'package:control_panel/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GithubLoginViewModel extends ChangeNotifier {
  Future<String?> tryLogin() async {
    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('$remoteWsDomain/login/v1/github/do-login'),
      );

      channel.stream.handleError((e) => throw e);
      int i = 0;

      await for (String data in channel.stream) {
        if (i == 0) {
          var jsonData = jsonDecode(data);
          var state = jsonData["state"];
          log("redirect_uri: $remoteHttpDomain/login/github-response");
          var loginGithubUrl =
              Uri.https("github.com", "login/oauth/authorize", {
            "client_id": "30bf4172998cc4ec684e",
            "state": state,
            "redirect_uri": "$remoteHttpDomain/login/github-response"
          });

          bool result = await launchUrl(loginGithubUrl);
          if (!result) {
            throw 'Cannot start browser';
          }
          i++;
        } else {
          var jsonData = jsonDecode(data);
          SharedPreferences sp = await SharedPreferences.getInstance();
          if (jsonData["error-code"] == 0) {
            sp.setString("accessToken", jsonData["access-token"]);
            return null;
          } else {
            return 'Backend error';
          }
        }
      }
    } catch (e) {
      debugPrint("$e");
      return 'Backend Error';
    }
    return 'Not complete';
  }
}

@immutable
abstract class ReturnState {
  const ReturnState();
}

@immutable
class LaunchURLState extends ReturnState {
  final Uri remoteURI;

  const LaunchURLState({required this.remoteURI});
}

@immutable
class AccessTokenState extends ReturnState {
  final String accessToken;

  const AccessTokenState({required this.accessToken});
}

@immutable
class ErrorState extends ReturnState {
  final String error;

  const ErrorState({required this.error});
}
