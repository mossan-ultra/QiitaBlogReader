import 'package:flutter/material.dart';
import 'package:qiita_reader/features/qiita/domain/aggregate/timeline.dart';
import 'package:qiita_reader/features/qiita/presentation/widgets/qiita_page_widget.dart';

import 'features/qiita/data/datasources/qiitaItems.dart';
import 'features/qiita/data/repositories/timeline_repository.dart';
import 'features/qiita/domain/usecases/timeline_read_usecase.dart';

void main() {
  runApp(const MyApp());
}
//https://qiita.com/najeira/items/454462c794c35b3b600a

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Qiita Blog Viewer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timeline? _timeline;

  Future<Timeline> loadTimeline() async {
    QiitaItemsReader reader = QiitaItemsReader();
    TimelineRepository repo = TimelineRepository(reader);
    TimelineReadUseCase timelineReadUseCase = TimelineReadUseCase(repo);
    _timeline = await timelineReadUseCase.excute(1);
    return Future<Timeline>.value(_timeline);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: loadTimeline(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Timeline tl = snapshot.data;
              var length = tl.value.length;
              return ListView.builder(
                itemCount: tl.value.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == length) {
                    //TODO: アイテム数を超えたので次のページを読み込む
                    // _load();

                    // 画面にはローディング表示しておく
                    return Center(
                      child: QiitaPageWidget(page: tl.value[index]),
                    );
                  } else if (index > length) {
                    // ローディング表示より先は無し
                    // return null;
                  }

                  // アイテムがあるので返す
                  var item = tl.value[index];
                  return QiitaPageWidget(page: item);
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
