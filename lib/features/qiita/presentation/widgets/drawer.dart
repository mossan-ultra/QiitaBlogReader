import 'package:flutter/material.dart';
import 'package:qiita_reader/features/qiita/presentation/widgets/setting_menu.dart';

import '../screens/gallery_screen.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: const [
    //     ListTile(title: Text("Setting")),
    //   ],
    // );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
        ),
        body: ListTile(
          leading: Container(
            width: 80,
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(.5),
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/setting.png'),
              ),
            ),
          ),
          title: const Text(
            'Setting',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.navigate_next),
          onTap: () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const SettingMenuPage(
                  key: Key('key'),
                ),
              ),
            ),
          },
        ));
  }
}
