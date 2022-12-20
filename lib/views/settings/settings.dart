import 'dart:developer';

import 'package:control_panel/data_structures/main_widget.dart';
import 'package:control_panel/data_structures/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends MainWidget {
  final ThemeType darkTheme;
  final bool smallDevice;
  final Function(ThemeType) setThemeType;

  const Settings(
      {super.key,
      required this.setThemeType,
      required this.darkTheme,
      required this.smallDevice});
  @override
  Widget build(BuildContext context) {
    ThemeType selected = darkTheme;
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('User info'),
          tiles: [
            SettingsTile.navigation(
              title: const Text('Register Phone'),
              leading: const Icon(Icons.phone),
              description: const Text('Register a telephone for alerts'),
              onPressed: (context) {
                debugPrint("register");
              },
            ),
            SettingsTile.navigation(
              title: const Text('Theme'),
              leading: const Icon(FontAwesomeIcons.paintRoller),
              description: const Text('Select theme'),
              onPressed: (context) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text("Select theme"),
                          content:
                              StatefulBuilder(builder: (context, setState) {
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                    title: const Text("System default"),
                                    value: ThemeType.system,
                                    groupValue: selected,
                                    onChanged: (ThemeType? value) {
                                      setThemeType(value ?? ThemeType.system);
                                      log("selected: $selected");
                                      setState(() {
                                        selected = value ?? ThemeType.system;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: const Text("Light"),
                                    value: ThemeType.light,
                                    groupValue: selected,
                                    onChanged: (ThemeType? value) {
                                      log("selected: $selected");
                                      setThemeType(value ?? ThemeType.system);
                                      setState(() {
                                        selected = value ?? ThemeType.system;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: const Text("Dark"),
                                    value: ThemeType.dark,
                                    groupValue: selected,
                                    onChanged: (ThemeType? value) {
                                      log("selected: $selected");
                                      setThemeType(value ?? ThemeType.system);
                                      setState(() {
                                        selected = value ?? ThemeType.system;
                                      });
                                      log("selected: $selected");
                                    },
                                  )
                                ]);
                          }));
                    });
              },
            ),
            SettingsTile.navigation(
              title: const Text('Link accounts'),
              leading: const Icon(FontAwesomeIcons.link),
              description: const Text(''),
              onPressed: (context) {
                debugPrint("Hihihih");
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text('Legal'),
          tiles: [
            SettingsTile.navigation(
              title: const Text('About'),
              leading: const Icon(FontAwesomeIcons.info),
              description: const Text(''),
              onPressed: (context) {
                showAboutDialog(
                    context: context,
                    applicationName: "Fridgigator",
                    applicationVersion: "1.0",
                    applicationIcon:
                        SvgPicture.asset('assets/assets/fridge.svg'));
              },
            ),
            SettingsTile.navigation(
              title: const Text('Licensing information'),
              leading: const Icon(FontAwesomeIcons.gavel),
              description:
                  const Text('Read all applicable Open Source licenses'),
              onPressed: (context) {
                showLicensePage(
                    context: context, applicationName: "Fridgigator");
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget getSideBar(BuildContext context) {
    return Container();
  }

  @override
  bool hasSideBar() {
    return false;
  }
}
