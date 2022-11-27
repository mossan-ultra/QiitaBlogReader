import 'package:qiita_reader/features/qiita/domain/value/createat.dart';
import 'package:qiita_reader/features/qiita/domain/value/updateAt.dart';
import 'package:qiita_reader/features/qiita/domain/value/url.dart';

import '../value/tag.dart';

class BlogPage {
  final String id;
  late final List<Tag> _tags;
  late final CreatedAt _createdAt;
  late final UpdateAt _updateAt;
  late final URL _url;
  late final String _title;
  late final String _image;

  BlogPage(
      {required this.id,
      required CreatedAt createdAt,
      required UpdateAt updateAt,
      required URL url,
      required String title,
      required List<Tag> tags,
      required String image}) {
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
    _image = image;
  }

  List<Tag> get tags => _tags;
  CreatedAt get createdAt => _createdAt;
  UpdateAt get updateAt => _updateAt;
  URL get url => _url;
  String get title => _title;
  String get image => _image;
}
