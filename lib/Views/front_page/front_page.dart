import 'package:control_panel/Views/dialogBox/login.dart';
import 'package:flutter/material.dart';
import 'front_page_button.dart';
import 'front_page_content.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FrontPageView();
}

class FrontPageView extends State<FrontPage> {
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
                  text: "Text",
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
                text: "Text",
                imageSource: "assets/lemon.svg",
                textPos: 1,
              ),
              FrontPageContent(
                title: "Technology",
                text: "Text",
                imageSource: "assets/network.svg",
                textPos: 2,
              ),
              FrontPageContent(
                  title: "Open Source",
                  text: "",
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
