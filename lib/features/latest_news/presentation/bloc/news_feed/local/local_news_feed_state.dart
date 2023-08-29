import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';

abstract class LocalNewsFeedState {
  final List<NewsFeedEntity>? newsFeed;

  const LocalNewsFeedState({this.newsFeed});
}

class LocalNewsFeedLoading extends LocalNewsFeedState {
  const LocalNewsFeedLoading();
}

class LocalNewsFeedDone extends LocalNewsFeedState {
  const LocalNewsFeedDone(List<NewsFeedEntity> newsFeed) : super(newsFeed: newsFeed);
}
