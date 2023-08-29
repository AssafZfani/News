import 'package:flutter/material.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/remote/remote_news_feed_state.dart';
import 'package:news/features/latest_news/presentation/widgets/news_feed_card.dart';

class NewsFeedListWidget extends StatelessWidget {
  final RemoteNewsFeedDone state;

  const NewsFeedListWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemBuilder: (context, index) => NewsFeedWidget(
          newsFeed: state.newsEntity!.news![index],
          onNewsFeedPressed: (newsFeed) => _onNewsFeedPressed(context, newsFeed),
        ),
        itemCount: state.newsEntity!.news!.length,
      );

  void _onNewsFeedPressed(BuildContext context, NewsFeedEntity newsFeed) {
    Navigator.pushNamed(context, '/NewsFeedDetails', arguments: newsFeed);
  }
}
