
import 'package:control_panel/data_structures/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel with ChangeNotifier {
  ThemeType _darkTheme = ThemeType.system;
  bool _doneLoading = false;
  String? _accessToken;
  bool _isCentigrade = true;

  ThemeType get themeType => _darkTheme;
  bool get doneLoading => _doneLoading;
  String? get accessToken => _accessToken;
  bool get isCentigrade => _isCentigrade;

  SharedPreferences? _sp;

  MainViewModel() {
    () async {
      var sp = await SharedPreferences.getInstance();
      var darkThemeString = sp.getString("darktheme");
      ThemeType t;
      if (darkThemeString == "dark") {
        t = ThemeType.dark;
      } else if (darkThemeString == "light") {
        t = ThemeType.light;
      } else {
        t = ThemeType.system;
      }
      isCentigrade = sp.getBool("centigrade") ?? true;
      accessToken = sp.getString("accessToken");
      themeType = t;
      _sp = sp;
      doneLoading = true;
      FlutterNativeSplash.remove();
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

  set themeType(ThemeType darkTheme) {
    _sp?.setString("darktheme", darkTheme.name);

    _darkTheme = darkTheme;
    notifyListeners();
  }

  set isCentigrade(bool centigrade) {
    _sp?.setBool("centigrade", centigrade);

    _isCentigrade = centigrade;
    notifyListeners();
  }

  void setCentigrade(bool cenrigrade) {
    isCentigrade = cenrigrade;
  }

  void login(String accessToken) {
    accessToken = accessToken;
    if (accessToken == "") {
      this.accessToken = null;
    }
  }

  void logout() {
    accessToken = "";
  }

  void setTheme(ThemeType t) {
    themeType = t;
  }
}
