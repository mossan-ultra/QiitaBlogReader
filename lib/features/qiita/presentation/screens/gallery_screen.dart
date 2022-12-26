import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../widgets/navifation.dart';
import 'gallery/android_settings_screen.dart';
import 'gallery/cross_platform_settings_screen.dart';
import 'gallery/ios_developer_screen.dart';
import 'gallery/web_chrome_settings.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: SettingsList(
        sections: [
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
                    screen: CrossPlatformSettingsScreen(
                      key: Key('key'),
                    ),
                    style: NavigationRouteStyle.material,
                  );
                },
              )
            ],
          ),
          SettingsSection(
            title: Text('Replications'),
            tiles: [
              SettingsTile.navigation(
                leading: Icon(CupertinoIcons.settings),
                title: Text('iOS Developer Screen'),
                onPressed: (context) {
                  Navigation.navigateTo(
                    context: context,
                    screen: IosDeveloperScreen(
                      key: Key('key'),
                    ),
                    style: NavigationRouteStyle.cupertino,
                  );
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.settings),
                title: Text('Android Settings Screen'),
                onPressed: (context) {
                  Navigation.navigateTo(
                    context: context,
                    screen: AndroidSettingsScreen(key: Key('key')),
                    style: NavigationRouteStyle.material,
                  );
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.web),
                title: Text('Web Settings'),
                onPressed: (context) {
                  Navigation.navigateTo(
                    context: context,
                    screen: WebChromeSettings(key: Key('key')),
                    style: NavigationRouteStyle.material,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
