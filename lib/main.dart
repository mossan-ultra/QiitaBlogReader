import 'package:flutter/material.dart';
import 'package:qiita_reader/features/qiita/domain/aggregate/timeline.dart';
import 'package:qiita_reader/features/qiita/presentation/widgets/qiita_page_widget.dart';

import 'features/qiita/data/datasources/qiitaItems.dart';
import 'features/qiita/data/repositories/timeline_repository.dart';
import 'features/qiita/domain/usecases/timeline_read_usecase.dart';
import 'features/qiita/presentation/widgets/blog_scroll_listview_widget.dart';

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
    return MaterialApp(
        home: Scaffold(
            drawer: Drawer(
              child: ListView(
                children: const [
                  DrawerHeader(
                      decoration: BoxDecoration(color: Colors.yellowAccent),
                      child: Text("My Home Page")),
                  ListTile(title: Text("menu1")),
                  ListTile(title: Text("menu2")),
                  ListTile(title: Text("menu3"))
                ],
              ),
            ),
            body: BlogScrollPage()));
  }
}
