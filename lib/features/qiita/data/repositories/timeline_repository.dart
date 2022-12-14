import 'dart:ui';

import 'package:qiita_reader/features/qiita/data/datasources/qiitaitems_reader_interface.dart';
import 'package:qiita_reader/features/qiita/domain/aggregate/timeline.dart';
import 'package:qiita_reader/features/qiita/domain/entities/page.dart';
import 'package:qiita_reader/features/qiita/domain/value/createat.dart';
import 'package:qiita_reader/features/qiita/domain/value/url.dart';

import '../../domain/repositories/timeline_repository_interface.dart';
import '../../domain/value/tag.dart';
import '../../domain/value/updateAt.dart';

class TimelineRepository implements TimelineRepositoryInterface {
  final QiitaItemsReaderInterface _qiitaItemReader;

  TimelineRepository(this._qiitaItemReader);

  @override
  Future<Timeline> readTimeLine(int page) async {
    List timelineBody = await _qiitaItemReader.read(page, <String>[]);
    Timeline timeline = Timeline();

    for (var element in timelineBody) {
      List<Tag> tags = [];

      String image = await _qiitaItemReader.getImage(Uri.parse(element['url']));

      BlogPage page = BlogPage(
          createdAt: CreatedAt(value: DateTime.parse(element['created_at'])),
          updateAt: UpdateAt(value: DateTime.parse(element['updated_at'])),
          id: element['id'],
          url: URL(value: element['url']),
          title: element['title'],
          tags: tags,
          image: image);
      timeline.add(page);
    }
    return Future<Timeline>.value(timeline);
  }

  @override
  Future<Timeline> readTimeLineOnFilter(
      int page, List<String> filterKeywords) async {
    List timelineBody = await _qiitaItemReader.read(page, filterKeywords);
    Timeline timeline = Timeline();

    for (var element in timelineBody) {
      List<Tag> tags = [];
      String image = await _qiitaItemReader.getImage(Uri.parse(element['url']));
      BlogPage page = BlogPage(
          createdAt: CreatedAt(value: DateTime.parse(element['created_at'])),
          updateAt: UpdateAt(value: DateTime.parse(element['updated_at'])),
          id: element['id'],
          url: URL(value: element['url']),
          title: element['title'],
          tags: tags,
          image: image);
      timeline.add(page);
    }
    return Future<Timeline>.value(timeline);
  }
}
