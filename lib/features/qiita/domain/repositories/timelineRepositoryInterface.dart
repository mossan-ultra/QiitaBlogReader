import 'package:qiita_reader/features/qiita/domain/aggregate/timeline.dart';

abstract class TimelineRepositoryInterface {
  Future<Timeline> readTimeLine();
}
