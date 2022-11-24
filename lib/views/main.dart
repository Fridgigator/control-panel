import 'package:control_panel/views/main_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_structures/main_view_state.dart';
import 'fridge_drawer.dart';
import 'main_navigation_rail.dart';
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
  MainViewState currentlySelectedPage = MainViewState.main;
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
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width <
            900;
    debugPrint(
        'size=${MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width}');
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
            drawer:
                !isOnSmallDevice ? null : FridgeDrawer(darkTheme: darkTheme),
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              double width =
                  MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                      .size
                      .width;

              if (width < 250) {
                return const Center(child: Text("Screen too small"));
              } else if (width < 900) {
                return Overview(darkTheme: darkTheme, smallDevice: true);
              } else {
                return MainNavigationRail(
                    mainView: Expanded(
                      child: Overview(
                          darkTheme: darkTheme, smallDevice: isOnSmallDevice),
                    ),
                    viewState: currentlySelectedPage,
                    changeViewState: (int? select) {
                      if (select == null) return;
                      setState(() {
                        currentlySelectedPage =
                            MainViewState.getByValue(select);
                      });
                    });
              }
            }),
            bottomNavigationBar: isOnSmallDevice
                ? MainBottomNavigationBar(
                    viewState: currentlySelectedPage,
                    changeViewState: (int? select) {
                      if (select == null) return;
                      setState(() {
                        currentlySelectedPage =
                            MainViewState.getByValue(select);
                      });
                    })
                : null));
  }
}
