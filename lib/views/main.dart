import 'dart:developer';

import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/data_structures/theme_type.dart';
import 'package:control_panel/libraries/stateless_snackbar/controller.dart';
import 'package:control_panel/view_model/main.dart';
import 'package:control_panel/views/fridges/fridges.dart';
import 'package:control_panel/views/settings/settings.dart';
import 'package:control_panel/views/hubs/hubs.dart';
import 'package:control_panel/views/main_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../data_structures/main_view_state.dart';
import ' main_navigation_rail.dart';
import 'login/login.dart';
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
  MainViewState currentlySelectedPage = MainViewState.overview;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainViewModel()),
        ],
        builder: (context, child) {
          ThemeData themeData;
          switch (Provider.of<MainViewModel>(context).themeType) {
            case ThemeType.dark:
              themeData = ThemeData.dark(useMaterial3: true);
              break;
            case ThemeType.light:
              themeData = ThemeData.light(useMaterial3: true);
              break;
            case ThemeType.system:
              themeData = SchedulerBinding
                          .instance.platformDispatcher.platformBrightness ==
                      Brightness.dark
                  ? ThemeData.dark(useMaterial3: true)
                  : ThemeData.light(useMaterial3: true);
              break;
          }
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeData,
              title: 'Control Panel',
              initialRoute: MainViewState.overview.name,
              onGenerateRoute: (settings) {
                return PageRouteBuilder(
                    settings: settings,
                    pageBuilder: (context, _, __) {
                      log("context=$settings, ${settings.name}");

                      final routes = {
                        "/": (context) => const OverviewScaffold(
                              pageToGo: MainViewState.overview,
                            ),
                        "overview": (context) => const OverviewScaffold(
                              pageToGo: MainViewState.overview,
                            ),
                        "hubs": (context) => const OverviewScaffold(
                              pageToGo: MainViewState.hubs,
                            ),
                        "fridges": (context) => const OverviewScaffold(
                              pageToGo: MainViewState.fridges,
                            ),
                        "settings": (context) => const OverviewScaffold(
                              pageToGo: MainViewState.settings,
                            ),
                      };
                      if (settings.name != "login") {
                        return routes[settings.name]!(context);
                      } else {
                        return LoginScaffold(
                            darkTheme:
                                Provider.of<MainViewModel>(context).themeType);
                      }
                    },
                    transitionDuration: const Duration(milliseconds: 800),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c));
              });
        });
  }
}

class OverviewScaffold extends StatelessWidget {
  final MainViewState pageToGo;
  const OverviewScaffold({super.key, required this.pageToGo});

  @override
  Widget build(BuildContext context) {
    return _MainScaffold(
      doneLoading: Provider.of<MainViewModel>(context).doneLoading,
      currentlySelectedPage: pageToGo,
      darkTheme: Provider.of<MainViewModel>(context).themeType,
      onLogin: Provider.of<MainViewModel>(context).login,
      onLogout: Provider.of<MainViewModel>(context).logout,
      accessToken: Provider.of<MainViewModel>(context).accessToken,
    );
  }
}

class _MainScaffold extends StatelessWidget {
  final MainViewState currentlySelectedPage;
  final ThemeType darkTheme;
  final String? accessToken;

  final bool doneLoading;
  final Function(String accessToken) onLogin;
  final Function() onLogout;

  const _MainScaffold({
    required this.darkTheme,
    required this.currentlySelectedPage,
    required this.accessToken,
    required this.doneLoading,
    required this.onLogin,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    String? accessToken = this.accessToken;
    if (!doneLoading) return const CircularProgressIndicator();
    if (accessToken == null) {
      return LoginScaffold(darkTheme: darkTheme);
    }
    bool isDarkTheme;
    switch (darkTheme) {
      case ThemeType.dark:
        isDarkTheme = true;
        break;
      case ThemeType.light:
        isDarkTheme = false;
        break;
      case ThemeType.system:
        isDarkTheme =
            MediaQuery.of(context).platformBrightness == Brightness.dark;
        break;
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      MainWidget widgetToDisplay;
      if (width < 250) {
        return const Scaffold(body: Center(child: Text("Screen too small")));
      }
      bool smallDevice = true;
      if (width < 900) {
        smallDevice = true;
      } else {
        smallDevice = false;
      }
      switch (currentlySelectedPage) {
        case MainViewState.overview:
          widgetToDisplay = Overview(
            darkTheme: isDarkTheme,
            smallDevice: smallDevice,
          );
          break;
        case MainViewState.hubs:
          widgetToDisplay =
              Hubs(darkTheme: isDarkTheme, smallDevice: smallDevice);
          break;
        case MainViewState.fridges:
          widgetToDisplay = Fridges(
              darkTheme: isDarkTheme,
              smallDevice: smallDevice,
              accessToken: accessToken);
          break;
        case MainViewState.settings:
          widgetToDisplay = Settings(
              setCentigrade: Provider.of<MainViewModel>(context).setCentigrade,
              centigrade: Provider.of<MainViewModel>(context).isCentigrade,
              darkTheme: darkTheme,
              smallDevice: smallDevice,
              accessToken: accessToken,
              setThemeType: Provider.of<MainViewModel>(context).setTheme);
      }

      return Scaffold(
          appBar: AppBar(
            title: const Text('Control Panel'),
            actions: [
              IconButton(
                  onPressed: () {
                    onLogout();
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: StatelessSnackbarController(
              child: !smallDevice
                  ? MainNavigationRail(
                      mainView: widgetToDisplay,
                      viewState: currentlySelectedPage,
                      changeViewState: (int? select) {
                        if (select == null) return;
                        Navigator.pushReplacementNamed(
                            context, MainViewState.getByValue(select).name);
                      })
                  : widgetToDisplay),
          floatingActionButton: widgetToDisplay.getFAB(context),
          bottomNavigationBar: smallDevice
              ? MainBottomNavigationBar(
                  viewState: currentlySelectedPage,
                  changeViewState: (int? select) {
                    if (select == null) return;
                    Navigator.pushReplacementNamed(
                        context, MainViewState.getByValue(select).name);
                  })
              : null);
    });
  }
}
