import 'package:news/core/usecase/usecase.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';
import 'package:news/features/latest_news/domain/repository/news_feed_repository.dart';

class GetSavedNewsFeedUseCase implements UseCase<List<NewsFeedEntity>, void> {
  final NewsFeedRepository _newsFeedRepository;

  GetSavedNewsFeedUseCase(this._newsFeedRepository);

  @override
  Future<List<NewsFeedEntity>> call({void params}) => _newsFeedRepository.getSavedNewsFeed();
}
