import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/qiita/presentation/Notifier/SettingsState.dart';
import 'features/qiita/presentation/widgets/blog_scroll_listview_widget.dart';
import 'features/qiita/presentation/widgets/drawer.dart';

void main() {
  runApp(const MyApp());
}
//https://qiita.com/najeira/items/454462c794c35b3b600a

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Qiita Blog Viewer'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final SettingsState settingsState = SettingsState();

    return ChangeNotifierProvider<SettingsState>(
      create: (context) => SettingsState(),
      child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(),
              drawer: const Drawer(
                child: DrawerMenu(),
              ),
              body: const BlogScrollPage())),
    );
  }
}
