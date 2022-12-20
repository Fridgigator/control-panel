import 'package:control_panel/data_structures/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends MainWidget {
  final bool darkTheme;
  final bool smallDevice;
  const Settings(
      {super.key, required this.darkTheme, required this.smallDevice});
  @override
  Widget build(BuildContext context) {
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
                debugPrint("Hihihih");
              },
            ),
            SettingsTile.navigation(
              title: const Text('Link to other accounts'),
              //leading: const Icon(Icons.license),
              description: const Text(
                  'Read all the Open Source licenses that are applicable'),
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
              title: const Text('Licensing information'),
              //leading: const Icon(Icons.license),
              description: const Text(
                  'Read all the Open Source licenses that are applicable'),
              onPressed: (context) {
                debugPrint("Hihihih");
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
