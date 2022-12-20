import 'dart:convert';
import 'dart:developer';

import 'package:control_panel/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GithubLoginViewModel extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
    log("Disposing");
  }

  Future<String?> tryLogin() async {
    const androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "Fridgigator",
      notificationText:
          "Background notification for keeping the app running in the background",
      notificationImportance: AndroidNotificationImportance.Default,
      notificationIcon:
          AndroidResource(name: 'background_icon', defType: 'drawable'),
    );
    try {
      var canDoBackground =
          await FlutterBackground.initialize(androidConfig: androidConfig);
      if (!canDoBackground) {
        return "Cannot stay alive in the background";
      }

      canDoBackground = await FlutterBackground.enableBackgroundExecution();
      if (!canDoBackground) {
        return "Cannot stay alive in the background";
      }
    } catch (e) {
      if (e is! MissingPluginException) {
        log("$e");
        return "Cannot stay alive in the background";
      }
    }
    WebSocketChannel channel;
    try {
      channel = WebSocketChannel.connect(
        Uri.parse('$remoteWsDomain/api/login/v1/github/do-login'),
      );

      channel.stream.handleError((e) => throw e);
      int i = 0;

      await for (String data in channel.stream) {
        log("$i");
        if (i == 0) {
          var jsonData = jsonDecode(data);
          var state = jsonData["state"];
          log("redirect_uri: $remoteHttpDomain/api/login/github-response");
          var loginGithubUrl =
              Uri.https("github.com", "login/oauth/authorize", {
            "client_id": clientID,
            "state": state,
            "redirect_uri": "$remoteHttpDomain/api/login/github-response"
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
            return jsonData["error-text"];
          }
        }
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "ACTIVITY_NOT_FOUND") {
          return "You may not have a proper app for viewing this content";
        }
        return ' ${e.message}';
      }
      log("$e");
      return 'Backend Error';
    }
    return 'Not complete';
  }
}
