import 'package:qiita_reader/features/qiita/data/datasources/qiitaitems_reader_interface.dart';
import 'package:qiita_reader/features/qiita/domain/aggregate/timeline.dart';
import 'package:qiita_reader/features/qiita/domain/entities/page.dart';
import 'package:qiita_reader/features/qiita/domain/value/createat.dart';
import 'package:qiita_reader/features/qiita/domain/value/url.dart';

import '../../domain/value/tag.dart';
import '../../domain/value/updateAt.dart';

class TimelineRepository {
  final QiitaItemsReaderInterface _qiitaItemReader;

  TimelineRepository(this._qiitaItemReader);

  Future<Timeline> readTimeLine() async {
    List timelineBody = await _qiitaItemReader.read(1);
    Timeline timeline = Timeline();

    for (var element in timelineBody) {
      List<Tag> tags = [];

      Page page = Page(
        createdAt: CreatedAt(value: DateTime.parse(element['created_at'])),
        updateAt: UpdateAt(value: DateTime.parse(element['updated_at'])),
        id: element['id'],
        url: URL(value: element['url']),
        title: element['title'],
        tags: tags,
      );
      timeline.add(page);
    }
    return Future<Timeline>.value(timeline);
  }
}
