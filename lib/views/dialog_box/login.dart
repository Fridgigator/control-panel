import 'dart:math';
import 'package:control_panel/structures/protobuf/FrontendBackend.pbserver.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginDialogState();
}

class LoginDialogState extends State<LoginDialog> {
  String nonce = "";
  late AppState currentState;
  String? accessToken;

  @override
  void initState() {
    super.initState();
    currentState = AppState.gettingNonce;
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString("access_code");
      if (accessToken != null) {
        setState(() {
          currentState = AppState.registerDevice;
          this.accessToken = accessToken;
        });
      } else {
        final channel = WebSocketChannel.connect(
          Uri.parse('wss://fridgigator-001.fly.dev/login/get-state'),
        );

        channel.stream.handleError((e) => debugPrint("error=$e"));
        channel.stream.listen((event) async {
          ToFrontEnd n = ToFrontEnd.fromBuffer(event);
          switch (n.whichType()) {
            case ToFrontEnd_Type.githubState:
              if (!mounted) {
                return;
              }
              setState(() {
                nonce = n.githubState.nonce;
                currentState = AppState.firstStageConnectToGithub;
              });
              break;
            case ToFrontEnd_Type.notSet:
              if (!mounted) {
                return;
              }

              setState(() {
                currentState = AppState.denied;
              });

              break;
            case ToFrontEnd_Type.accessCode:
              if (n.accessCode.failed) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  currentState = AppState.denied;
                });
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("access_code", n.accessCode.accessCode);
                if (!mounted) {
                  return;
                }

                setState(() {
                  currentState = AppState.registerDevice;
                  this.accessToken = n.accessCode.accessCode;
                });
              }
          }
        },
            onError: (e) => debugPrint("error1=$e"),
            onDone: () => debugPrint("Done"));
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

  Widget getView(AppState appState, StateSetter setState) {
    switch (appState) {
      case AppState.gettingNonce:
        return Column(children: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("Step 1")),
          Text("Getting Nonce"),
        ]);
      case AppState.firstStageConnectToGithub:
        var loginGithubUrl = Uri.https("github.com", "login/oauth/authorize", {
          "client_id": "30bf4172998cc4ec684e",
          "state": nonce,
        });
        return Column(children: [
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
        ]);

      case AppState.waitingForGitHub:
        //getServerData(0, setState);
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [CircularProgressIndicator(value: null)]);
      case AppState.registerDevice:
        Navigator.pop(context, accessToken);
        return Container();
      case AppState.gitHubBug:
        return Column(children: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("GitHub login failed"))
        ]);
      case AppState.gitHubTimeout:
        return Column(children: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("GitHub login timed out"))
        ]);
      case AppState.denied:
        return Column(children: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Text("GitHub Denied"))
        ]);
    }
  }

  static String generateNonce() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random.secure();

    return String.fromCharCodes(Iterable.generate(
        25, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}

enum AppState {
  gettingNonce,
  firstStageConnectToGithub,
  waitingForGitHub,
  gitHubTimeout,
  gitHubBug,
  registerDevice,
  denied
}
