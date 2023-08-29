import 'package:news/core/usecase/usecase.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';
import 'package:news/features/latest_news/domain/repository/news_feed_repository.dart';

class SaveNewsFeedUseCase implements UseCase<void, NewsFeedEntity> {
  final NewsFeedRepository _newsFeedRepository;

  SaveNewsFeedUseCase(this._newsFeedRepository);

  @override
  Future<void> call({NewsFeedEntity? params}) => _newsFeedRepository.saveNewsFeed(params!);
}
