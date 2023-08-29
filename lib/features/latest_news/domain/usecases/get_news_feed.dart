import 'package:news/core/resources/data_state.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/features/latest_news/domain/entities/news_entity.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';
import 'package:news/features/latest_news/domain/repository/news_feed_repository.dart';

class GetNewsFeedUseCase implements UseCase<DataState<NewsEntity>, String> {
  final NewsFeedRepository _newsFeedRepository;

  GetNewsFeedUseCase(this._newsFeedRepository);

  @override
  Future<DataState<NewsEntity>> call({String? params}) async {
    DataState<List<String>> categories = await _newsFeedRepository.getCategories();
    DataState<List<NewsFeedEntity>> news = await _newsFeedRepository.getNewsFeed(query: params);
    if (categories is DataSuccess && news is DataSuccess) {
      return DataSuccess(NewsEntity(categories: categories.data, news: news.data));
    } else if (categories is DataFailed) {
      return DataFailed(categories.error!);
    } else {
      return DataFailed(news.error!);
    }
  }
}
