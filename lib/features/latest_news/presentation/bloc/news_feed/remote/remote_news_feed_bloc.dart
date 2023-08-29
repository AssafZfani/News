import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/resources/data_state.dart';
import 'package:news/features/latest_news/domain/usecases/get_news_feed.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/remote/remote_news_feed_event.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/remote/remote_news_feed_state.dart';

class RemoteNewsFeedBloc extends Bloc<RemoteNewsFeedEvent, RemoteNewsFeedState> {
  final GetNewsFeedUseCase _getNewsFeedUseCase;

  RemoteNewsFeedBloc(this._getNewsFeedUseCase) : super(const RemoteNewsFeedLoading()) {
    on<GetNewsFeed>(onGetNewsFeed);
  }

  void onGetNewsFeed(GetNewsFeed event, Emitter<RemoteNewsFeedState> emit) async {
    final dataState = await _getNewsFeedUseCase(params: event.query);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteNewsFeedDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteNewsFeedError(dataState.error!));
    }
  }
}
