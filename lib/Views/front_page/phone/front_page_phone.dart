import 'package:flutter/material.dart';

import '../../dialogBox/login.dart';
import '../front_page_button.dart';
import 'front_page_content.dart';

class FrontPagePhone extends StatefulWidget {
  const FrontPagePhone({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FrontPagePhoneView();
}

class FrontPagePhoneView extends State<FrontPagePhone> {
  String? accessToken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 0),
            child: SingleChildScrollView(
                child: Center(
                    child: Column(children: [
              FrontPageContent(
                  title: "Monitors your fridge",
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  imageSource: "assets/fridge.svg",
                  textPos: 0,
                  buttons: [
                    FrontPageButton(
                        text: "Login",
                        onClick: accessToken != null
                            ? null
                            : () async {
                                String? accessToken = await startLoginButton();
                                setState(() {
                                  this.accessToken = accessToken;
                                });
                              }),
                    FrontPageButton(
                      text: "Learn More",
                      onClick: () {},
                    )
                  ]),
              FrontPageContent(
                title: "The perfect place for your produce",
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                imageSource: "assets/lemon.svg",
                textPos: 1,
              ),
              FrontPageContent(
                title: "Technology",
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                imageSource: "assets/network.svg",
                textPos: 2,
              ),
              FrontPageContent(
                  title: "Open Source",
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  imageSource: "assets/Opensource.svg",
                  textPos: 3,
                  buttons: [FrontPageButton(text: "GitHub", onClick: () {})])
            ])))),
        appBar: AppBar(actions: [
          TextButton(onPressed: () {}, child: Text("Control Panel")),
          TextButton(
              onPressed: () async {
                String? accessToken = await startLoginButton();
                print(accessToken);
                setState(() {
                  this.accessToken = accessToken;
                });
              },
              child: Text(accessToken == null ? "Login" : "Logout"))
        ]));
  }

  Future<String?> startLoginButton() async {
    return await showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "Barrier",
        barrierColor: Colors.grey.withOpacity(0.5),
        context: context,
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) {
          return StatefulBuilder(builder: (context, setState) {
            return const DialogBox();
          });
        },
        transitionBuilder: (_, anim, __, child) {
          Tween<Offset> tween;
          if (anim.status == AnimationStatus.reverse) {
            tween = Tween(begin: Offset(0, 11), end: Offset.zero);
          } else {
            tween = Tween(begin: Offset(0, -1), end: Offset.zero);
          }

          return SlideTransition(
            position: tween.animate(anim),
            child: FadeTransition(
              opacity: anim,
              child: child,
            ),
          );
        });
  }
}
