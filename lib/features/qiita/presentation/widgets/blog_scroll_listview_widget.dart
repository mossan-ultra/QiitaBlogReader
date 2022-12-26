import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qiita_reader/features/qiita/data/datasources/qiitaItems.dart';
import 'package:qiita_reader/features/qiita/data/repositories/timeline_repository.dart';
import 'package:qiita_reader/features/qiita/domain/aggregate/timeline.dart';
import 'package:qiita_reader/features/qiita/domain/entities/page.dart';
import 'package:qiita_reader/features/qiita/domain/usecases/timeline_read_usecase.dart';
import 'package:qiita_reader/features/qiita/presentation/widgets/qiita_page_widget.dart';

import '../Notifier/SettingsState.dart';

class BlogScrollPage extends StatefulWidget {
  const BlogScrollPage({Key? key}) : super(key: key);

  @override
  State<BlogScrollPage> createState() => _BlogScrollPage();
}

class BlogPageContext {
  List<BlogPage> contents = [];
  int currentLoadLength = 0;
  int totalLoadLength = 0;

  BlogPageContext({
    required this.contents,
    required this.currentLoadLength,
    required this.totalLoadLength,
  });
}

class _BlogScrollPage extends State<BlogScrollPage> {
  List<BlogPage> contents = [];
  int loadLength = 0;
  int currentLoadLength = 0;

  int _page = 1;
  late Timeline? _timeline;

  Future<void> _getContents(BuildContext context) async {
    List<String> filterKeywordList = context.read<SettingsState>().keywordList;

    QiitaItemsReader reader = QiitaItemsReader();
    TimelineRepository repo = TimelineRepository(reader);
    TimelineReadUseCase timelineReadUseCase = TimelineReadUseCase(repo);
    try {
      _timeline =
          await timelineReadUseCase.excuteOnFilter(_page, filterKeywordList);
    } on Exception catch (exception) {
      {
        print('exception $exception');
      }
    }
    for (int i = 0; i < _timeline!.value.length; i++) {
      contents.add(_timeline!.value[i]);
    }
    currentLoadLength = _timeline!.value.length;

    loadLength += _timeline!.value.length;
    _page++;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _getContents(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return InfinityBlogListView(
            contents: BlogPageContext(
                contents: contents,
                currentLoadLength: currentLoadLength,
                totalLoadLength: loadLength),
            getContents: _getContents,
            buildContext: context,
          );
        },
      ),
    );
  }
}

class InfinityBlogListView extends StatefulWidget {
  final BlogPageContext contents;
  final BuildContext buildContext;
  final Future<void> Function(BuildContext context) getContents;

  const InfinityBlogListView({
    Key? key,
    required this.buildContext,
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

        await widget.getContents(widget.buildContext);

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
      itemCount: widget.contents.contents.length + 1,
      separatorBuilder: (BuildContext context, int index) => Container(
        width: double.infinity,
        height: 2,
        color: Colors.grey,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (widget.contents.contents.length == index) {
          if (widget.contents.totalLoadLength < 10) {
            widget.getContents(context);
          }
          return const SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Center(
          child: QiitaPageWidget(page: widget.contents.contents[index]),
        );
      },
    );
  }
}
