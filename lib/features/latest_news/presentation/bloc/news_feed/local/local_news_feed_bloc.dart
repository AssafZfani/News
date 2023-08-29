import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/latest_news/domain/usecases/get_saved_news_feed.dart';
import 'package:news/features/latest_news/domain/usecases/remove_news_feed.dart';
import 'package:news/features/latest_news/domain/usecases/save_news_feed.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/local/local_news_feed_event.dart';

import 'local_news_feed_state.dart';

class LocalNewsFeedBloc extends Bloc<LocalNewsFeedEvent, LocalNewsFeedState> {
  final GetSavedNewsFeedUseCase _getSavedNewsFeedUseCase;
  final SaveNewsFeedUseCase _saveNewsFeedUseCase;
  final RemoveNewsFeedUseCase _removeNewsFeedUseCase;

  LocalNewsFeedBloc(this._getSavedNewsFeedUseCase, this._saveNewsFeedUseCase, this._removeNewsFeedUseCase)
      : super(const LocalNewsFeedLoading()) {
    on<GetSavedNewsFeed>(onGetSavedNewsFeed);
    on<RemoveNewsFeed>(onRemoveNewsFeed);
    on<SaveNewsFeed>(onSaveNewsFeed);
  }

  void onGetSavedNewsFeed(GetSavedNewsFeed event, Emitter<LocalNewsFeedState> emit) async {
    final newsFeed = await _getSavedNewsFeedUseCase();
    emit(LocalNewsFeedDone(newsFeed));
  }

  void onRemoveNewsFeed(RemoveNewsFeed removeNewsFeed, Emitter<LocalNewsFeedState> emit) async {
    await _removeNewsFeedUseCase(params: removeNewsFeed.newsFeed);
    final newsFeed = await _getSavedNewsFeedUseCase();
    emit(LocalNewsFeedDone(newsFeed));
  }

  void onSaveNewsFeed(SaveNewsFeed saveNewsFeed, Emitter<LocalNewsFeedState> emit) async {
    await _saveNewsFeedUseCase(params: saveNewsFeed.newsFeed);
    final newsFeed = await _getSavedNewsFeedUseCase();
    emit(LocalNewsFeedDone(newsFeed));
  }
}
