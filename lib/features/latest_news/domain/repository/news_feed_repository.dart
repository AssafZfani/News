import 'package:news/core/resources/data_state.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';

abstract class NewsFeedRepository {
  // API methods
  Future<DataState<List<String>>> getCategories();

  Future<DataState<List<NewsFeedEntity>>> getNewsFeed({String? query});

  // Database methods
  Future<List<NewsFeedEntity>> getSavedNewsFeed();

  Future<void> saveNewsFeed(NewsFeedEntity newsFeedItem);

  Future<void> removeNewsFeed(NewsFeedEntity newsFeedItem);
}
