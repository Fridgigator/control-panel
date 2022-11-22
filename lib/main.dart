import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({super.key});
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
  SharedPreferences? sp;
  @override
  void initState() {
    super.initState();
    () async {
      sp = await SharedPreferences.getInstance();
    }();
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = sp?.getBool("darktheme") ?? false;
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
        drawer: loggedIn ? getDrawer() : null,
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }

  Drawer? getDrawer() {
    bool darkTheme = sp?.getBool("darktheme") ?? false;

    bool isOnSmallDevice =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .shortestSide <
            600;

    return !isOnSmallDevice
        ? null
        : Drawer(
            child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: const AssetImage('assets/manyFridges.png'),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                      fit: BoxFit.fill),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 24,
                  child: Text("Fridges",
                      style: TextStyle(
                          color: darkTheme ? Colors.white70 : Colors.black87,
                          fontSize: 32)),
                ),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.add_box),
                title: const Text("Add Fridge"),
                onTap: () {},
              ),
            ],
          ));
  }
}
