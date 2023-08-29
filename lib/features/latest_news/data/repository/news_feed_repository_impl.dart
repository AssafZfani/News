import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news/core/constants/constants.dart';
import 'package:news/core/resources/data_state.dart';
import 'package:news/features/latest_news/data/data_sources/local/app_database.dart';
import 'package:news/features/latest_news/data/data_sources/remote/news_feed_api_service.dart';
import 'package:news/features/latest_news/data/models/news_feed_model.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';
import 'package:news/features/latest_news/domain/repository/news_feed_repository.dart';

class NewsFeedRepositoryImpl implements NewsFeedRepository {
  final NewsFeedApiService _newsFeedApiService;
  final AppDatabase _appDatabase;

  NewsFeedRepositoryImpl(this._newsFeedApiService, this._appDatabase);

  @override
  Future<DataState<List<String>>> getCategories() async {
    try {
      final httpResponse = await _newsFeedApiService.getCategories(apiKey: newsAPIKey);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.categories);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<NewsFeedModel>>> getNewsFeed({String? query}) async {
    try {
      final httpResponse =
          await _newsFeedApiService.getNewsFeed(apiKey: newsAPIKey, language: languageQuery, keywords: query);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.news);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<NewsFeedModel>> getSavedNewsFeed() async => _appDatabase.newsFeedDAO.getNewsFeed();

  @override
  Future<void> removeNewsFeed(NewsFeedEntity newsFeed) =>
      _appDatabase.newsFeedDAO.deleteNewsFeed(NewsFeedModel.fromEntity(newsFeed));

  @override
  Future<void> saveNewsFeed(NewsFeedEntity newsFeed) =>
      _appDatabase.newsFeedDAO.insertNewsFeed(NewsFeedModel.fromEntity(newsFeed));
}
