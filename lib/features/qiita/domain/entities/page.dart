
import 'package:qiita_reader/features/qiita/domain/value/createat.dart';
import 'package:qiita_reader/features/qiita/domain/value/updateAt.dart';
import 'package:qiita_reader/features/qiita/domain/value/url.dart';

import '../value/tag.dart';

class Page {
  final String id;
  late List<Tag> _tags;
  late CreatedAt _createdAt;
  late UpdateAt _updateAt;
  late URL _url;
  late String _title;

  Page(
      {required this.id,
      required CreatedAt createdAt,
      required UpdateAt updateAt,
      required URL url,
      required String title,
      required List<Tag> tags}) {
    if (id.isEmpty) {
      throw Exception('Tag value is not empty');
    }
    if (title.isEmpty) {
      throw Exception('Tag value is not empty');
    }
    _createdAt = createdAt;
    _tags = tags;
    _title = title;
    _updateAt = updateAt;
    _url = url;
  }

  List<Tag> get tags => _tags;
  CreatedAt get createdAt => _createdAt;
  UpdateAt get updateAt => _updateAt;
  URL get url => _url;
  String get title => _title;
}
