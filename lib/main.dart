import 'dart:convert';

import 'package:control_panel/structures/data_types.dart';
import 'package:control_panel/views/dialog_box/add_fridge.dart';
import 'package:control_panel/views/dialog_box/add_sensor.dart';
import 'package:control_panel/views/dialog_box/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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
  String? curUser;
  SharedPreferences? prefs;
  List<Fridge> fridges = [];
  List<Hub> hubs = [];

  @override
  void initState() {
    super.initState();

    () async {
      prefs = await SharedPreferences.getInstance();
      setState(() {
        accessCode = prefs?.getString("access_code");
        debugPrint("Setting access token = $accessCode");
      });
      getData();
    }();
  }

  @override
  Widget build(BuildContext context) {
    String? accessCode = this.accessCode;
    List<SpeedDialChild> newAddOptions = [
      SpeedDialChild(
        child: const Icon(Icons.sensor_window),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        label: 'New Fridge',
        onTap: () async {
          await startPopup(AddFridge(accessToken: accessCode!));
          getData();
        },
      )
    ];
    newAddOptions.add(SpeedDialChild(
      child: const Icon(Icons.hub),
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      label: 'New Hub',
      onTap: () async {
        await startPopup(AddHub(accessToken: accessCode!));
        getData();
      },
    ));

    if (hubs.isNotEmpty && fridges.isNotEmpty) {
      newAddOptions.add(SpeedDialChild(
        child: const Icon(Icons.sensors_sharp),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        label: 'New Sensor',
        onTap: () async {
          await startPopup(AddSensor(accessToken: accessCode!));
          getData();
        },
      ));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Control Panel"), actions: [
        TextButton(
            onPressed: () async {
              if (accessCode == null) {
                String? recToken =
                    await startPopup(const LoginDialog()) as String?;
                if (recToken != null && prefs != null) {
                  debugPrint("setting githubToken");
                  prefs?.setString("access_code", recToken);

                  setState(() {
                    this.accessCode = recToken;
                  });
                  getData();
                }
              } else {
                () async {
                  await prefs?.remove("access_code");
                  setState(() {
                    debugPrint("logging out");
                    this.accessCode = null;
                  });
                }();
              }
            },
            child: Text(accessCode == null ? "Login" : "Logout"))
      ]),
      body: FrontPage(
          accessCode: "$accessCode",
          fridges: fridges,
          loggedIn: accessCode == "",
          remoteName: curUser,
          hubs: hubs),
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
        children: newAddOptions,
      ),
    );
  }

  Future<Object?> startPopup(Widget widget) async {
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

  Future<void> getData() async {
    String? accessCode = this.accessCode;
    if (accessCode != null) {
      http.Response r = await http.post(
          Uri.parse('https://fridgigator.herokuapp.com/api/get-user-info'),
          headers: <String, String>{'Authorization': accessCode});
      Map<String, dynamic> user = jsonDecode(r.body);
      debugPrint("user=$user");

      var response = await http.get(
          Uri.parse('https://fridgigator.herokuapp.com/api/get-overview'),
          headers: {'Authorization': accessCode});
      if (response.statusCode == 200) {
        var jsonResult = json.decode(response.body);
        List<dynamic> fridges = jsonResult['fridges'];
        List<dynamic> hubs = jsonResult['hubs'];
        setState(() {
          this.fridges = fridges.map((e) {
            return Fridge(
                name: e["name"],
                uuid: e["uuid"],
                sensors: (e["sensors"] as List<dynamic>).map((e) {
                  return Sensor(
                      model: e["model"],
                      uuid: e["uuid"],
                      name: e["name"],
                      value: e["lastValue"]);
                }).toList());
          }).toList();

          this.hubs = hubs.map((e) {
            return Hub(
              uuid: e["uuid"],
            );
          }).toList();
        });
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
      setState(() {
        curUser = user["login"];
      });
    }
  }
}
