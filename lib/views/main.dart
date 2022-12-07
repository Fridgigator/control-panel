import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/views/fridges/fridges.dart';
import 'package:control_panel/views/settings/settings.dart';
import 'package:control_panel/views/hubs/hubs.dart';
import 'package:control_panel/views/main_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_structures/main_view_state.dart';
import ' main_navigation_rail.dart';
import 'overview/overview.dart';

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
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<_MyAppState> {
  bool darkTheme = false;
  bool doneLoading = false;
  bool loggedIn = false;
  SharedPreferences? sp;
  MainViewState currentlySelectedPage = MainViewState.overview;

  @override
  void initState() {
    super.initState();
    () async {
      sp = await SharedPreferences.getInstance();
      setState(() {
        doneLoading = true;
        darkTheme = sp?.getBool("darktheme") ?? false;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    overviewScaffold(pageToGo) => _MainScaffold(
          doneLoading: doneLoading,
          currentlySelectedPage: pageToGo,
          darkTheme: darkTheme,
          invertDarkTheme: () {
            setState(() {
              darkTheme = !darkTheme;
              sp?.setBool("darktheme", darkTheme);
            });
          },
          logOut: () {
            setState(() {
              loggedIn = !loggedIn;
            });
          },
          loggedIn: loggedIn,
        );
    debugPrint("darktheme=$darkTheme");
    return MaterialApp(
      theme: darkTheme ? ThemeData.dark() : ThemeData.light(),
      //darkTheme: ,
      title: 'Control Panel',
      initialRoute: MainViewState.overview.name,
      routes: {
        "/": (context) => overviewScaffold(MainViewState.overview),
        MainViewState.overview.name: (context) =>
            overviewScaffold(MainViewState.overview),
        MainViewState.hubs.name: (context) =>
            overviewScaffold(MainViewState.hubs),
        MainViewState.fridges.name: (context) =>
            overviewScaffold(MainViewState.fridges),
        MainViewState.settings.name: (context) =>
            overviewScaffold(MainViewState.settings),
      },
    );
  }
}

class _MainScaffold extends StatelessWidget {
  final MainViewState currentlySelectedPage;
  final bool darkTheme;
  final bool loggedIn;

  final void Function() invertDarkTheme;
  final void Function() logOut;

  final bool doneLoading;

  const _MainScaffold({
    required this.darkTheme,
    required this.currentlySelectedPage,
    required this.invertDarkTheme,
    required this.loggedIn,
    required this.logOut,
    required this.doneLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (!doneLoading) return const CircularProgressIndicator();
    bool isOnSmallDevice =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width <
            900;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Control Panel'),
          actions: [
            IconButton(
                onPressed: invertDarkTheme,
                icon: Icon(darkTheme ? Icons.light_mode : Icons.dark_mode)),
            IconButton(
                onPressed: logOut,
                icon: Icon(loggedIn ? Icons.logout : Icons.login))
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double width =
              MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .size
                  .width;

          if (width < 250) {
            return const Center(child: Text("Screen too small"));
          } else if (width < 900) {
            switch (currentlySelectedPage) {
              case MainViewState.overview:
                return Overview(darkTheme: darkTheme, smallDevice: true);
              case MainViewState.hubs:
                return Hubs(darkTheme: darkTheme, smallDevice: true);
              case MainViewState.fridges:
                return Fridges(darkTheme: darkTheme, smallDevice: true);
              case MainViewState.settings:
                return Settings(darkTheme: darkTheme, smallDevice: true);
            }
          } else {
            MainWidget child;
            switch (currentlySelectedPage) {
              case MainViewState.overview:
                child = Overview(darkTheme: darkTheme, smallDevice: false);
                break;
              case MainViewState.hubs:
                child = Hubs(darkTheme: darkTheme, smallDevice: false);
                break;
              case MainViewState.fridges:
                child = Fridges(darkTheme: darkTheme, smallDevice: false);
                break;
              case MainViewState.settings:
                child = Settings(darkTheme: darkTheme, smallDevice: false);
            }

            return MainNavigationRail(
                mainView: child,
                viewState: currentlySelectedPage,
                changeViewState: (int? select) {
                  if (select == null) return;
                  Navigator.pushNamed(
                      context, MainViewState.getByValue(select).name);
                });
          }
        }),
        bottomNavigationBar: isOnSmallDevice
            ? MainBottomNavigationBar(
                viewState: currentlySelectedPage,
                changeViewState: (int? select) {
                  if (select == null) return;
                  Navigator.pushNamed(
                      context, MainViewState.getByValue(select).name);
                })
            : null);
  }
}
