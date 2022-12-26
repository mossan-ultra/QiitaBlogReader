import 'package:qiita_reader/features/qiita/domain/aggregate/timeline.dart';
import 'package:qiita_reader/features/qiita/domain/usecases/timeline_read_usecase_interface.dart';

import '../repositories/timeline_repository_interface.dart';

class TimelineReadUseCase implements TimelineReadUseCaseInterface {
  final TimelineRepositoryInterface _timelineRepository;
  TimelineReadUseCase(this._timelineRepository);
  @override
  Future<Timeline> excute(int page) async {
    Timeline timeline = await _timelineRepository.readTimeLine(page);

    return Future<Timeline>.value(timeline);
  }

  Future<Timeline> excuteOnFilter(int page, List<String> filterKeywords) async {
    Timeline timeline =
        await _timelineRepository.readTimeLineOnFilter(page, filterKeywords);

    return Future<Timeline>.value(timeline);
  }
}
