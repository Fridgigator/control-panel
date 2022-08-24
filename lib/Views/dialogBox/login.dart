import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginDialogState();
}

class LoginDialogState extends State<LoginDialog> {
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
          print("accessToken=$accessToken");
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
          "state": nonce,
        });
        debugPrint("uri=$loginGithubUrl");
        return Container(
            child: Column(children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("Step 1")),
          ElevatedButton(
            child: const Text("Login through GitHub"),
            onPressed: () async {
              setState(() {
                currentState = AppState.waitingForGitHub;
              });
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
      case AppState.denied:
        return Container(
            child: Column(children: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("GitHub Denied"))
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
      var url = Uri.https(
          'fridgigator.herokuapp.com', 'verifyGitHubLogin', {"nonce": nonce});
      var response = await http.get(url);
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      if (responseMap["ok"] == "ok") {
        debugPrint("Getting access_token=$responseMap");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", responseMap["access_token"]);
        setState(() {
          currentState = AppState.registerDevice;
          accessToken = responseMap["access_token"];
        });
      } else if (responseMap["ok"] == "denied") {
        setState(() {
          currentState = AppState.denied;
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
  registerDevice,
  denied
}
