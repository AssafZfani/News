import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/local/local_news_feed_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/local/local_news_feed_event.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/local/local_news_feed_state.dart';
import 'package:news/features/latest_news/presentation/widgets/news_feed_card.dart';
import 'package:news/injection_container.dart';

class FavoritesNews extends StatelessWidget {
  const FavoritesNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => get<LocalNewsFeedBloc>()..add(const GetSavedNewsFeed()),
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ),
      );

  _buildAppBar() => AppBar(
        leading: Builder(
          builder: (context) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onBackButtonTapped(context),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: const Text('Favorites', style: TextStyle(color: Colors.black)),
      );

  Widget _buildBody() => BlocBuilder<LocalNewsFeedBloc, LocalNewsFeedState>(
        builder: (context, state) {
          if (state is LocalNewsFeedLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is LocalNewsFeedDone) {
            return _buildNewsFeedList(state.newsFeed!);
          }
          return Container();
        },
      );

  Widget _buildNewsFeedList(List<NewsFeedEntity> newsFeed) {
    if (newsFeed.isEmpty) {
      return const Center(
          child: Text(
        'There are no favorites news yet',
        style: TextStyle(color: Colors.black),
      ));
    }

    return ListView.builder(
      itemCount: newsFeed.length,
      itemBuilder: (context, index) => NewsFeedWidget(
        newsFeed: newsFeed[index],
        isRemovable: true,
        onRemove: (newsFeed) => _onRemoveNewsFeed(context, newsFeed),
        onNewsFeedPressed: (newsFeed) => _onNewsFeedPressed(context, newsFeed),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveNewsFeed(BuildContext context, NewsFeedEntity newsFeed) {
    BlocProvider.of<LocalNewsFeedBloc>(context).add(RemoveNewsFeed(newsFeed));
  }

  void _onNewsFeedPressed(BuildContext context, NewsFeedEntity newsFeed) {
    Navigator.pushNamed(context, '/NewsFeedDetails', arguments: newsFeed);
  }
}
