import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel with ChangeNotifier {
  bool _darkTheme = false;
  bool _doneLoading = false;
  String? _accessToken;

  bool get darkTheme => _darkTheme;
  bool get doneLoading => _doneLoading;
  String? get accessToken => _accessToken;

  SharedPreferences? _sp;

  MainViewModel() {
    log("New");
    () async {
      var sp = await SharedPreferences.getInstance();
      log("New1");
      darkTheme = sp.getBool("darktheme") ?? false;
      log("New2");
      accessToken = sp.getString("accessToken");
      log("New3");
      _sp = sp;
      log("New4");
      doneLoading = true;
      log("New5");
      FlutterNativeSplash.remove();
      log("Done");
    }();
  }

  set accessToken(String? accessToken) {
    _sp?.setString("accessToken", accessToken ?? "");
    if (accessToken == "") {
      _accessToken = null;
    } else {
      _accessToken = accessToken;
    }
    notifyListeners();
  }

  set doneLoading(bool doneLoading) {
    _doneLoading = doneLoading;
    notifyListeners();
  }

  set darkTheme(bool darkTheme) {
    _sp?.setBool("darktheme", darkTheme);

    _darkTheme = darkTheme;
    notifyListeners();
  }

  void login(String accessToken) {
    log("Done, accessToken=$accessToken");

    accessToken = accessToken;
    if (accessToken == "") {
      this.accessToken = null;
    }
  }

  void logout() {
    accessToken = "";
  }

  void invertTheme() {
    darkTheme = !darkTheme;
  }
}
