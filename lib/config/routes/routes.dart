import 'package:flutter/material.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';
import 'package:news/features/latest_news/presentation/pages/authenticate/authenticate.dart';
import 'package:news/features/latest_news/presentation/pages/favorites_news/favorites_news.dart';
import 'package:news/features/latest_news/presentation/pages/home/home.dart';
import 'package:news/features/latest_news/presentation/pages/news_feed_detail/news_feed_detail.dart';
import 'package:news/features/latest_news/presentation/pages/profile/profile.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppRoutes {
  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/Authenticate':
        return _materialRoute(const Authenticate());

      case 'Home':
        return _materialRoute(const Home());

      case '/NewsFeedDetails':
        return _materialRoute(NewsFeedDetailsView(newsFeed: settings.arguments as NewsFeedEntity));

      case '/FavoritesNews':
        return _materialRoute(const FavoritesNews());

      case '/WebView':
        return _materialRoute(WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..loadRequest(Uri.parse(settings.arguments as String))));

      case '/Profile':
        return _materialRoute(const Profile());

      default:
        return _materialRoute(const Authenticate());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
