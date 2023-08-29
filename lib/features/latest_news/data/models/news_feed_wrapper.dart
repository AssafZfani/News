import 'package:news/features/latest_news/data/models/news_feed_model.dart';

class NewsFeedWrapper {
  List<NewsFeedModel> news;

  NewsFeedWrapper({required this.news});

  factory NewsFeedWrapper.fromJson(Map<String, dynamic> map) =>
      NewsFeedWrapper(news: (map['news'] as List).map((newsFeedJson) => NewsFeedModel.fromJson(newsFeedJson)).toList());
}
