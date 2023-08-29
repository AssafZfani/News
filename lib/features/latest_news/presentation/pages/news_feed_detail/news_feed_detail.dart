import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/local/local_news_feed_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/local/local_news_feed_event.dart';
import 'package:news/features/latest_news/presentation/widgets/text_box.dart';
import 'package:news/injection_container.dart';

class NewsFeedDetailsView extends StatelessWidget {
  final NewsFeedEntity newsFeed;

  const NewsFeedDetailsView({super.key, required this.newsFeed});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => get<LocalNewsFeedBloc>()..add(SaveNewsFeed(newsFeed)),
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() => AppBar(backgroundColor: Colors.green[700], title: Text(newsFeed.title!), actions: [
        Builder(
            builder: (context) => IconButton(
                onPressed: () => _onFavoritePressed(context), icon: const Icon(Icons.star, color: Colors.white)))
      ]);

  Widget _buildBody() => SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildImage(),
            _buildFooter(),
          ],
        ),
      );

  Widget _buildHeader() => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              newsFeed.title!,
              style: const TextStyle(fontFamily: 'Butler', fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            // DateTime
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  newsFeed.author!,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(newsFeed.published!)),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildImage() => Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 250,
        child: Image.network(newsFeed.image!, fit: BoxFit.cover),
      );

  Widget _buildFooter() => Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                newsFeed.description!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text(
                    'Related categories',
                    style: TextStyle(fontFamily: 'Butler', fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                childAspectRatio: 2,
                crossAxisCount: 3,
                children: newsFeed.category!.map((String value) => TextBoxWidget(text: value)).toList(),
              ),
              RichText(
                  text: TextSpan(
                text: newsFeed.url!,
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _onUrlLinkPressed(context, newsFeed.url!);
                  },
              ))
            ],
          ),
        );
      });

  void _onFavoritePressed(BuildContext context) {
    BlocProvider.of<LocalNewsFeedBloc>(context).add(SaveNewsFeed(newsFeed));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text(
          'Article saved successfully.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _onUrlLinkPressed(BuildContext context, String url) {
    Navigator.pushNamed(context, '/WebView', arguments: url);
  }
}
