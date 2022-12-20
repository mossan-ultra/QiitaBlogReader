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
    // final fromPlatform = useMemoized(PackageInfo.fromPlatform);
    // final snapshot = useFuture(fromPlatform);
    // if (!snapshot.hasData) {
    //   return const SizedBox.shrink();
    // }

    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('設定画面'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: const Text('Language'),
              value: const Text('Japanese'),
              description: const Text('description'),
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
        SettingsSection(
          title: Text('General'),
          tiles: [
            SettingsTile.navigation(
              title: Text('Abstract settings screen'),
              leading: Icon(CupertinoIcons.wrench),
              description: Text('UI created to show plugin\'s possibilities'),
              onPressed: (context) {
                Navigation.navigateTo(
                  context: context,
                  screen: KeywordInputMenu(
                    key: Key('key'),
                  ),
                  style: NavigationRouteStyle.material,
                );
              },
            )
          ],
        ),
        // SettingsSection(
        //   title: const Text('セクション'),
        //   tiles: <SettingsTile>[
        //     SettingsTile(
        //         leading: const Icon(Icons.info),
        //         title: const Text('アプリのバージョン'),
        //         value: Text("${snapshot.data?.version}"))
        //   ],
        // ),
      ],
    );
  }
}
