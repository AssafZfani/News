import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/remote/remote_news_feed_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/remote/remote_news_feed_event.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/remote/remote_news_feed_state.dart';
import 'package:news/features/latest_news/presentation/widgets/news_feed_list.dart';
import 'package:news/features/latest_news/presentation/widgets/text_box.dart';
import 'package:news/injection_container.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppbar(context),
        body: _buildBody(false),
        backgroundColor: Colors.green[50],
      );

  _buildAppbar(BuildContext context) => AppBar(
        backgroundColor: Colors.green[900],
        title: const Text(
          'News Feed',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: CustomSearchDelegate(bodyWidget: _buildBody(true))),
              icon: const Icon(Icons.search, color: Colors.white)),
          IconButton(
              onPressed: () => _onShowFavoritesViewPressed(context), icon: const Icon(Icons.star, color: Colors.white)),
          IconButton(
              onPressed: () => _onProfileViewPressed(context), icon: const Icon(Icons.more_vert, color: Colors.white)),
        ],
      );

  _buildBody(bool fromSearch) => BlocBuilder<RemoteNewsFeedBloc, RemoteNewsFeedState>(
        builder: (_, state) {
          if (state is RemoteNewsFeedLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is RemoteNewsFeedError) {
            return const Center(child: Icon(Icons.refresh));
          }
          if (state is RemoteNewsFeedDone) {
            return fromSearch ? NewsFeedListWidget(state: state) : HomeWidget(state: state);
          }
          return Container();
        },
      );

  void _onShowFavoritesViewPressed(BuildContext context) {
    Navigator.pushNamed(context, '/FavoritesNews');
  }

  void _onProfileViewPressed(BuildContext context) {
    Navigator.pushNamed(context, '/Profile');
  }
}

class HomeWidget extends StatelessWidget {
  final RemoteNewsFeedDone state;

  const HomeWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Categories',
                style: TextStyle(fontFamily: 'Butler', fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => TextBoxWidget(text: state.newsEntity!.categories![index]),
                itemCount: state.newsEntity!.categories!.length,
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Latest News',
                style: TextStyle(fontFamily: 'Butler', fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        Expanded(
          child: NewsFeedListWidget(state: state),
        ),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final Widget bodyWidget;

  CustomSearchDelegate({required this.bodyWidget});

  @override
  Widget buildResults(BuildContext context) => BlocProvider(
        create: (_) => get<RemoteNewsFeedBloc>()..add(GetNewsFeed(query: query)),
        child: bodyWidget,
      );

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  Widget? buildLeading(BuildContext context) => null;

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
