import 'package:qiita_reader/features/qiita/domain/aggregate/timeline.dart';

abstract class TimelineReadUseCaseInterface {
  Future<Timeline> excute(int page);
}
