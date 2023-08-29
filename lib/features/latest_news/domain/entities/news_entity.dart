import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';

class NewsEntity {
  final List<String>? categories;
  final List<NewsFeedEntity>? news;

  NewsEntity({required this.categories, required this.news});
}
