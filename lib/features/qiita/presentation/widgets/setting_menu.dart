import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qiita_reader/features/qiita/presentation/widgets/keyword_input.dart';
import 'package:qiita_reader/features/qiita/presentation/widgets/navifation.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingMenuPage extends StatelessWidget {
  const SettingMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('General settings'),
          tiles: [
            SettingsTile.navigation(
              title: const Text('Search Keyword'),
              leading: const Icon(CupertinoIcons.keyboard),
              description: const Text('Setting keywords to search'),
              onPressed: (context) {
                Navigation.navigateTo(
                  context: context,
                  screen: const KeywordInputMenu(
                    key: Key('key'),
                  ),
                  style: NavigationRouteStyle.material,
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
