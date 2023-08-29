import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news/features/latest_news/data/data_sources/local/app_database.dart';
import 'package:news/features/latest_news/domain/repository/news_feed_repository.dart';
import 'package:news/features/latest_news/domain/usecases/get_news_feed.dart';
import 'package:news/features/latest_news/domain/usecases/remove_news_feed.dart';
import 'package:news/features/latest_news/domain/usecases/save_news_feed.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/auth/auth_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/local/local_news_feed_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/remote/remote_news_feed_bloc.dart';

import 'features/latest_news/data/data_sources/remote/news_feed_api_service.dart';
import 'features/latest_news/data/repository/news_feed_repository_impl.dart';
import 'features/latest_news/domain/usecases/get_saved_news_feed.dart';

final get = GetIt.instance;

Future<void> initializeDependencies() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  get.registerSingleton<AppDatabase>(database);

  // Dio
  get.registerSingleton<Dio>(Dio());

  // Dependencies
  get.registerSingleton<NewsFeedApiService>(NewsFeedApiService(get()));

  get.registerSingleton<NewsFeedRepository>(NewsFeedRepositoryImpl(get(), get()));

  // UseCases
  get.registerSingleton<GetNewsFeedUseCase>(GetNewsFeedUseCase(get()));

  get.registerSingleton<GetSavedNewsFeedUseCase>(GetSavedNewsFeedUseCase(get()));

  get.registerSingleton<SaveNewsFeedUseCase>(SaveNewsFeedUseCase(get()));

  get.registerSingleton<RemoveNewsFeedUseCase>(RemoveNewsFeedUseCase(get()));

  // Blocs
  get.registerFactory<AuthBloc>(() => AuthBloc());

  get.registerFactory<RemoteNewsFeedBloc>(() => RemoteNewsFeedBloc(get()));

  get.registerFactory<LocalNewsFeedBloc>(() => LocalNewsFeedBloc(get(), get(), get()));
}
