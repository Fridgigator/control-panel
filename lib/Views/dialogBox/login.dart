import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DialogBox extends StatefulWidget {
  const DialogBox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DialogBoxState();
}

class DialogBoxState extends State<DialogBox> {
  final String nonce = generateNonce();
  late AppState currentState;
  String? accessToken;

  @override
  void initState() {
    super.initState();
    currentState = AppState.firstStageConnectToGithub;
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString("access_token");
      if (accessToken != null) {
        setState(() {
          currentState = AppState.registerDevice;
          this.accessToken = accessToken;
        });
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 240,
        child: AlertDialog(content: getView(currentState, setState)),
        margin: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }

  Container getView(AppState appState, StateSetter setState) {
    dev.log("appState=$appState");
    switch (appState) {
      case AppState.firstStageConnectToGithub:
        var loginGithubUrl = Uri.https("github.com", "login/oauth/authorize", {
          "client_id": "30bf4172998cc4ec684e",
          "redirect_uri": "http://localhost:1234/register",
          "state": nonce,
        });
        return Container(
            child: Column(children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("Step 1")),
          ElevatedButton(
            child: const Text("Login through GitGub"),
            onPressed: () async {
              setState(() {
                dev.log("SetState");
                currentState = AppState.waitingForGitHub;
              });
              dev.log("about to launch");
              if (!await launchUrl(loginGithubUrl)) {
                throw 'Could not launch $loginGithubUrl';
              }
            },
          )
        ]));

      case AppState.waitingForGitHub:
        getServerData(0, setState);
        return Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [CircularProgressIndicator(value: null)]));
      case AppState.registerDevice:
        print("at=$accessToken");
        Navigator.pop(context, accessToken);
        return Container();
      case AppState.gitHubBug:
        return Container(
            child: Column(children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("GitHub login failed"))
        ]));
      case AppState.gitHubTimeout:
        return Container(
            child: Column(children: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("GitHub login timed out"))
        ]));
    }
  }

  static String generateNonce() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random.secure();

    return String.fromCharCodes(Iterable.generate(
        25, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  void getServerData(
    int amntTimesCalled,
    StateSetter setState,
  ) async {
    if (amntTimesCalled > 15) {
      setState(() {
        currentState = AppState.gitHubTimeout;
      });
    } else {
      var url =
          Uri.http('localhost:1234', 'verifyGitHubLogin', {"nonce": nonce});
      var response = await http.get(url);
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (responseMap["ok"]) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", responseMap["access_token"]);
        setState(() {
          currentState = AppState.registerDevice;
          accessToken = responseMap["access_token"];
        });
      } else {
        await Future.delayed(
          Duration(seconds: amntTimesCalled * 2),
        );
        getServerData(amntTimesCalled + 1, setState);
      }
    }
  }
}

enum AppState {
  firstStageConnectToGithub,
  waitingForGitHub,
  gitHubTimeout,
  gitHubBug,
  registerDevice
}
