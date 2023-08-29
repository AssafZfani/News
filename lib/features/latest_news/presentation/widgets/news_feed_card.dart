import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';

class NewsFeedWidget extends StatelessWidget {
  final NewsFeedEntity? newsFeed;
  final bool? isRemovable;
  final void Function(NewsFeedEntity newsFeed)? onRemove;
  final void Function(NewsFeedEntity newsFeed)? onNewsFeedPressed;

  const NewsFeedWidget({
    Key? key,
    this.newsFeed,
    this.onNewsFeedPressed,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _onTap,
        child: Card(
          color: Colors.green[700],
          elevation: 10,
          margin: const EdgeInsetsDirectional.all(16),
          child: Column(
            children: [_buildTitle(), _buildImage(context), _buildDateTimeAndRemovableArea()],
          ),
        ),
      );

  Widget _buildTitle() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          newsFeed!.title ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      );

  Widget _buildImage(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.network(newsFeed!.image!),
      );

  Widget _buildDateTimeAndRemovableArea() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRemovableArea(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(newsFeed!.published!)),
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      );

  Widget _buildRemovableArea() {
    if (isRemovable!) {
      return GestureDetector(
        onTap: _onRemove,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.star, color: Colors.white),
        ),
      );
    }
    return Container();
  }

  void _onTap() {
    if (onNewsFeedPressed != null) {
      onNewsFeedPressed!(newsFeed!);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(newsFeed!);
    }
  }
}
