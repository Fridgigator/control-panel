import 'package:control_panel/views/dialog_box/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/main_display/front_page.dart';
import 'views/dialog_box/add_hub.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Refrigigators '),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? accessCode;
  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    () async {
      prefs = await SharedPreferences.getInstance();
      setState(() {
        accessCode = prefs?.getString("access_code");
        debugPrint("Setting access token = $accessCode");
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    String? accessCode = this.accessCode;
    return Scaffold(
      appBar: AppBar(title: const Text("Control Panel"), actions: [
        TextButton(
            onPressed: () async {
              if (accessCode == null) {
                String? recToken =
                    await startLoginButton(const LoginDialog()) as String?;
                if (recToken != null && prefs != null) {
                  debugPrint("setting githubToken");
                  prefs?.setString("access_code", recToken);
                  setState(() {
                    this.accessCode = recToken;
                  });
                }
              } else {
                () async {
                  await prefs?.remove("access_code");
                  setState(() {
                    this.accessCode = null;
                  });
                }();
              }
            },
            child: Text(accessCode == null ? "Login" : "Logout"))
      ]),
      body: FrontPage(accessCode: "$accessCode"),
      floatingActionButton: SpeedDial(
        visible: accessCode != null,
        icon: Icons.add,
        onPress: null,
        activeIcon: Icons.close,
        spacing: 3,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        renderOverlay: true,
        useRotationAnimation: true,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        animationDuration: const Duration(milliseconds: 250),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add_box),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'New Fridge',
          ),
          SpeedDialChild(
            child: const Icon(Icons.hub),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            label: 'New Hub',
            onTap: () async {
              await startLoginButton(AddHub(accessToken: accessCode!));
            },
          ),
        ],
      ),
    );
  }

  Future<Object?> startLoginButton(Widget widget) async {
    Object? a = await showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "Barrier",
        barrierColor: Colors.grey.withOpacity(0.5),
        context: context,
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) {
          return StatefulBuilder(builder: (context, setState) {
            return widget;
          });
        },
        transitionBuilder: (_, anim, __, child) {
          Tween<Offset> tween;
          if (anim.status == AnimationStatus.reverse) {
            tween = Tween(begin: const Offset(0, 11), end: Offset.zero);
          } else {
            tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
          }

          return SlideTransition(
            position: tween.animate(anim),
            child: FadeTransition(
              opacity: anim,
              child: child,
            ),
          );
        });
    return a;
  }
}
