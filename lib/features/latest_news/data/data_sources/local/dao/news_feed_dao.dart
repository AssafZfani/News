import 'package:floor/floor.dart';
import 'package:news/features/latest_news/data/models/news_feed_model.dart';

@dao
abstract class NewsFeedDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNewsFeed(NewsFeedModel newsFeed);

  @delete
  Future<void> deleteNewsFeed(NewsFeedModel newsFeedModel);

  @Query('SELECT * FROM news')
  Future<List<NewsFeedModel>> getNewsFeed();
}
