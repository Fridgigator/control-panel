import 'dart:async';
import 'dart:convert';

import 'package:control_panel/structures/data_types.dart';
import 'package:control_panel/views/dialog_box/add_fridge.dart';
import 'package:control_panel/views/dialog_box/add_phone.dart';
import 'package:control_panel/views/dialog_box/add_sensor.dart';
import 'package:control_panel/views/dialog_box/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'views/main_display/front_page.dart';
import 'views/dialog_box/add_hub.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  DateTime currentTime = DateTime.now();
  @override
  void initState() {
    super.initState();

    () async {
      prefs = await SharedPreferences.getInstance();
      setState(() {
        accessCode = prefs?.getString("access_code");
      });
      await getData();
      Timer.periodic(const Duration(milliseconds: 1000), (t) {
        setState(() {
          currentTime = DateTime.now();
        });
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    String? accessCode = this.accessCode;
    List<SpeedDialChild> newAddOptions = [
      SpeedDialChild(
        child: const Icon(Icons.sensor_window),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        label: 'New Fridge',
        onTap: () async {
          await startPopup(AddFridge(accessToken: accessCode!));
        },
      )
    ];

    newAddOptions.add(SpeedDialChild(
      child: const Icon(Icons.hub),
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      label: 'New Hub',
      onTap: () async {
        await startPopup(AddHub(accessToken: accessCode!));
      },
    ));

    if (hubs.isNotEmpty && fridges.isNotEmpty) {
      newAddOptions.add(SpeedDialChild(
        child: const Icon(Icons.sensors_sharp),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        label: 'New Sensor',
        onTap: () async {
          await startPopup(AddSensor(
            accessToken: accessCode!,
            fridges: fridges,
          ));
        },
      ));
    }

    newAddOptions.add(SpeedDialChild(
      child: const Icon(Icons.phone),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      label: 'Set Phone',
      onTap: () async {
        await startPopup(PhoneSettings(
          accessToken: accessCode!,
        ));
      },
    ));

    return Scaffold(
      appBar: AppBar(title: const Text("Control Panel"), actions: [
        TextButton(
            onPressed: () async {
              if (accessCode == null) {
                String? recToken =
                    await startPopup(const LoginDialog()) as String?;
                if (recToken != null && prefs != null) {
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
      body: FrontPage(
          key: ValueKey(currentTime.microsecond),
          clock: currentTime,
          accessCode: accessCode,
          fridges: fridges,
          loggedIn: accessCode != null,
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
      try {
        http.Response r = await http.post(
            Uri.parse('https://fridgigator-001.fly.dev/api/get-user-info'),
            headers: <String, String>{
              'Authorization': accessCode
            }).onError((error, stackTrace) {
          throw "$stackTrace ${error ?? "UnkownError"}";
        });
        Map<String, dynamic> user = jsonDecode(r.body);
        setState(() {
          curUser = user["login"];
        });

        final channel = WebSocketChannel.connect(
          Uri.parse(
              'wss://fridgigator-001.fly.dev/api/frontend/v1/get-overview?authorization=$accessCode'),
        );

        debugPrint('sending');
        channel.stream.handleError((e) => debugPrint("error=$e"));
        channel.stream.listen(
          (event) async {
            debugPrint('event=$event');
            var response = json.decode(event);
            if (response["status-code"] == 200) {
              switch (response['update-what']) {
                case 'FRIDGE':
                  List<dynamic> fridges = response['fridges'];

                  setState(() {
                    this.fridges = fridges.map((e) {
                      debugPrint("e=$e");
                      return Fridge(
                          name: e["name"],
                          uuid: e["uuid"],
                          sensors: (e["sensors"] as List<dynamic>)
                              .where((e) => e["name"] != "")
                              .map((e) {
                            debugPrint("e=$e");
                            return Sensor(
                                model: Sensor.modelFromNumber(e['model']),
                                uuid: e["uuid"],
                                name: e["name"],
                                location: e["location"],
                                time: e["time"],
                                key: e["key"],
                                typeOfData: e["typeOfData"],
                                value: e["value"]);
                          }).toList());
                    }).toList();
                  });
                  break;
                case 'HUB':
                  List<dynamic> hubs = response['hubs'];
                  setState(() {
                    this.hubs = hubs.map((e) {
                      return Hub(
                        lastConnected: e["lastConnected"],
                        uuid: e["uuid"],
                      );
                    }).toList();
                  });
                  break;
                case 'SENSOR':
                  Sensor newSensor = Sensor(
                      model: Sensor.modelFromNumber(
                          response['sensor-data']['model']),
                      uuid: response['sensor-data']['uuid'],
                      name: response['sensor-data']['name'],
                      location: response['sensor-data']['location'],
                      time: response['sensor-data']['time'],
                      key: response['sensor-data']['key'],
                      typeOfData: response['sensor-data']['typeOfData'],
                      value: response['sensor-data']['value']);
                  bool changed = false;
                  for (var fridge in fridges) {
                    for (int i = 0; i < fridge.sensors.length; i++) {
                      if (fridge.sensors[i].uuid == newSensor.uuid &&
                          fridge.sensors[i].typeOfData ==
                              newSensor.typeOfData &&
                          fridge.sensors[i].key != newSensor.key) {
                        changed = true;
                        fridge.sensors[i] = newSensor;
                      }
                    }
                  }
                  debugPrint("changed=$changed");
                  if (changed) {
                    List<Fridge> f = fridges.map((fridge) {
                      Fridge f = Fridge(
                          name: fridge.name,
                          uuid: fridge.uuid,
                          sensors: fridge.sensors
                              .map((e) => Sensor(
                                    key: e.key,
                                    uuid: e.uuid,
                                    model: e.model,
                                    name: e.name,
                                    value: e.value,
                                    location: e.location,
                                    time: e.time,
                                    typeOfData: e.typeOfData,
                                  ))
                              .toList());
                      return f;
                    }).toList();
                    setState(() {
                      fridges = f;
                    });
                  }
                  break;
              }
            } else if (response["status-code"] == 403) {
              var jsonResult = response['json-result'];
              var error = jsonResult['error'];
              if (error == "invalid-access-token") {
                await prefs?.remove("access_code");
                setState(() {
                  this.accessCode = null;
                });
              }
            } else {
              // If that response was not OK, throw an error.
              throw Exception('Failed to load post');
            }
          },
          onDone: () {
            Timer(const Duration(seconds: 2), getData);
          },
          onError: (error, stackTrace) {
            debugPrint("error $error, $stackTrace");
          },
        );
      } catch (e) {
        debugPrint("Error caught: $e");
        Timer(const Duration(seconds: 2), getData);
      }
    }
  }
}
