import 'package:dio/dio.dart';
import 'package:news/core/constants/constants.dart';
import 'package:news/features/latest_news/data/models/categories_wrapper.dart';
import 'package:news/features/latest_news/data/models/news_feed_wrapper.dart';
import 'package:retrofit/retrofit.dart';

part 'news_feed_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsFeedApiService {
  factory NewsFeedApiService(Dio dio) = _NewsFeedApiService;

  @GET('/available/categories')
  Future<HttpResponse<CategoriesWrapper>> getCategories({
    @Query("apiKey") String? apiKey,
  });

  @GET('/search')
  Future<HttpResponse<NewsFeedWrapper>> getNewsFeed({
    @Query("apiKey") String? apiKey,
    @Query("language") String? language,
    @Query("keywords") String? keywords,
  });
}
