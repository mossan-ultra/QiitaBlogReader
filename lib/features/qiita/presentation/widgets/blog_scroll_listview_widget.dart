import 'package:flutter/material.dart';
import 'package:qiita_reader/features/qiita/data/datasources/qiitaItems.dart';
import 'package:qiita_reader/features/qiita/data/repositories/timeline_repository.dart';
import 'package:qiita_reader/features/qiita/domain/aggregate/timeline.dart';
import 'package:qiita_reader/features/qiita/domain/entities/page.dart';
import 'package:qiita_reader/features/qiita/domain/usecases/timeline_read_usecase.dart';
import 'package:qiita_reader/features/qiita/presentation/widgets/qiita_page_widget.dart';

class BlogScrollPage extends StatefulWidget {
  const BlogScrollPage({Key? key}) : super(key: key);

  @override
  State<BlogScrollPage> createState() => _BlogScrollPage();
}

class _BlogScrollPage extends State<BlogScrollPage> {
  final List<BlogPage> _contents = [];
  final int loadLength = 20;

  int _page = 1;
  late Timeline? _timeline;

  Future<void> _getContents() async {
    QiitaItemsReader reader = QiitaItemsReader();
    TimelineRepository repo = TimelineRepository(reader);
    TimelineReadUseCase timelineReadUseCase = TimelineReadUseCase(repo);
    _timeline = await timelineReadUseCase.excute(_page);
    for (int i = 0; i < _timeline!.value.length; i++) {
      _contents.add(_timeline!.value[i]);
    }
    _page++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _getContents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            //4
            return InfinityBlogListView(
              contents: _contents,
              getContents: _getContents,
            );
          },
        ),
      ),
    );
  }
}

class InfinityBlogListView extends StatefulWidget {
  final List<BlogPage> contents;
  // final List<String> contents;
  final Future<void> Function() getContents;

  const InfinityBlogListView({
    Key? key,
    required this.contents,
    required this.getContents,
  }) : super(key: key);

  @override
  State<InfinityBlogListView> createState() => _InfinityBlogListView();
}

class _InfinityBlogListView extends State<InfinityBlogListView> {
  late ScrollController _scrollController;
  bool _isLoading = false;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.95 &&
          !_isLoading) {
        _isLoading = true;

        await widget.getContents();

        setState(() {
          _isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: widget.contents.length + 1,
      separatorBuilder: (BuildContext context, int index) => Container(
        width: double.infinity,
        height: 2,
        color: Colors.grey,
      ),
      itemBuilder: (BuildContext context, int index) {
        //11
        if (widget.contents.length == index) {
          return const SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Center(
          child: QiitaPageWidget(page: widget.contents[index]),
        );
      },
    );
  }
}
