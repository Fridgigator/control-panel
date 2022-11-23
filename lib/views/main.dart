import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fridge_drawer.dart';
import 'main_connection_stats.dart';
import 'overview.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const _MyAppState();
  }
}

class _MyAppState extends StatefulWidget {
  const _MyAppState({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<_MyAppState> {
  bool loggedIn = false;
  bool doneLoading = false;
  SharedPreferences? sp;
  @override
  void initState() {
    super.initState();
    () async {
      sp = await SharedPreferences.getInstance();
      setState(() {
        doneLoading = true;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    if (!doneLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    bool darkTheme = sp?.getBool("darktheme") ?? false;
    bool isOnSmallDevice =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .shortestSide <
            600;

    return MaterialApp(
        theme: ThemeData(),
        darkTheme: darkTheme ? ThemeData.dark() : ThemeData.light(),
        title: 'Control Panel',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Control Panel'),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        sp?.setBool("darktheme", !darkTheme);
                      });
                    },
                    icon: Icon(darkTheme ? Icons.light_mode : Icons.dark_mode)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        loggedIn = !loggedIn;
                      });
                    },
                    icon: Icon(loggedIn ? Icons.logout : Icons.login))
              ],
            ),
            drawer: loggedIn
                ? !isOnSmallDevice
                    ? null
                    : FridgeDrawer(darkTheme: darkTheme)
                : null,
            body:
                Overview(darkTheme: darkTheme, smallDevice: isOnSmallDevice)));
  }
}
