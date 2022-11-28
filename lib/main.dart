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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
    return Scaffold(
      appBar: AppBar(
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
