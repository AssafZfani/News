import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';

abstract class LocalNewsFeedEvent {
  final NewsFeedEntity? newsFeed;

  const LocalNewsFeedEvent({this.newsFeed});
}

class GetSavedNewsFeed extends LocalNewsFeedEvent {
  const GetSavedNewsFeed();
}

class RemoveNewsFeed extends LocalNewsFeedEvent {
  const RemoveNewsFeed(NewsFeedEntity newsFeed) : super(newsFeed: newsFeed);
}

class SaveNewsFeed extends LocalNewsFeedEvent {
  const SaveNewsFeed(NewsFeedEntity newsFeed) : super(newsFeed: newsFeed);
}
