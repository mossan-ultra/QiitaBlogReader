import 'package:qiita_reader/features/qiita/domain/entities/page.dart';

class Timeline {
  late final List<BlogPage> value;

  Timeline() {
    value = [];
  }
  void add(BlogPage page) {
    value.add(page);
  }
}
