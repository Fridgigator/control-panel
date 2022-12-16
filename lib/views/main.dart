import 'dart:developer';

import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/view_model/main.dart';
import 'package:control_panel/views/fridges/fridges.dart';
import 'package:control_panel/views/settings/settings.dart';
import 'package:control_panel/views/hubs/hubs.dart';
import 'package:control_panel/views/main_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
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
    bool isOnSmallDevice =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width <
            900;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainViewModel()),
        ],
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Provider.of<MainViewModel>(context).darkTheme
                  ? ThemeData.dark()
                  : ThemeData.light(),
              title: 'Control Panel',
              initialRoute: MainViewState.overview.name,
              onGenerateRoute: (settings) {
                return PageRouteBuilder(
                    settings: settings,
                    pageBuilder: (context, _, __) {
                      log("context=$settings, ${settings.name}");

                      final routes = {
                        "/": (context) => OverviewScaffold(
                              pageToGo: MainViewState.overview,
                              isOnSmallDevice: isOnSmallDevice,
                            ),
                        "overview": (context) => OverviewScaffold(
                              pageToGo: MainViewState.overview,
                              isOnSmallDevice: isOnSmallDevice,
                            ),
                        "hubs": (context) => OverviewScaffold(
                              pageToGo: MainViewState.hubs,
                              isOnSmallDevice: isOnSmallDevice,
                            ),
                        "fridges": (context) => OverviewScaffold(
                              pageToGo: MainViewState.fridges,
                              isOnSmallDevice: isOnSmallDevice,
                            ),
                        "settings": (context) => OverviewScaffold(
                              pageToGo: MainViewState.settings,
                              isOnSmallDevice: isOnSmallDevice,
                            ),
                      };
                      if (settings.name != "login") {
                        return routes[settings.name]!(context);
                      } else {
                        return LoginScaffold(
                            darkTheme:
                                Provider.of<MainViewModel>(context).darkTheme);
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
  final bool isOnSmallDevice;
  const OverviewScaffold(
      {super.key, required this.pageToGo, required this.isOnSmallDevice});

  @override
  Widget build(BuildContext context) {
    return _MainScaffold(
      doneLoading:
          Provider.of<MainViewModel>(context, listen: false).doneLoading,
      currentlySelectedPage: pageToGo,
      darkTheme: Provider.of<MainViewModel>(context, listen: false).darkTheme,
      onLogin: Provider.of<MainViewModel>(context, listen: false).login,
      onLogout: Provider.of<MainViewModel>(context, listen: false).logout,
      isOnSmallDevice: isOnSmallDevice,
      invertDarkTheme:
          Provider.of<MainViewModel>(context, listen: false).invertTheme,
      accessToken:
          Provider.of<MainViewModel>(context, listen: false).accessToken,
    );
  }
}

class _MainScaffold extends StatelessWidget {
  final MainViewState currentlySelectedPage;
  final bool darkTheme;
  final String? accessToken;

  final void Function() invertDarkTheme;

  final bool doneLoading;
  final bool isOnSmallDevice;
  final Function(String accessToken) onLogin;
  final Function() onLogout;

  const _MainScaffold({
    required this.darkTheme,
    required this.currentlySelectedPage,
    required this.invertDarkTheme,
    required this.accessToken,
    required this.doneLoading,
    required this.isOnSmallDevice,
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Control Panel'),
          actions: [
            IconButton(
                onPressed: invertDarkTheme,
                icon: Icon(darkTheme ? Icons.light_mode : Icons.dark_mode)),
            IconButton(
                onPressed: () {
                  onLogout();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;

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
