import 'package:dio/dio.dart';
import 'package:news/features/latest_news/domain/entities/news_entity.dart';

abstract class RemoteNewsFeedState {
  final NewsEntity? newsEntity;
  final DioException? error;

  const RemoteNewsFeedState({this.newsEntity, this.error});
}

class RemoteNewsFeedLoading extends RemoteNewsFeedState {
  const RemoteNewsFeedLoading();
}

class RemoteNewsFeedDone extends RemoteNewsFeedState {
  const RemoteNewsFeedDone(NewsEntity newsEntity) : super(newsEntity: newsEntity);
}

class RemoteNewsFeedError extends RemoteNewsFeedState {
  const RemoteNewsFeedError(DioException error) : super(error: error);
}
