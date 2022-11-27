import 'package:qiita_reader/features/qiita/domain/entities/page.dart';

class Timeline {
  late List<Page> _value;

  Timeline() {
    _value = [];
  }
  void add(Page page) {
    _value.add(page);
  }
}
