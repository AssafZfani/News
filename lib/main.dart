import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/config/routes/routes.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/auth/auth_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/remote/remote_news_feed_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/remote/remote_news_feed_event.dart';
import 'package:news/features/latest_news/presentation/pages/wrapper.dart';

import 'features/latest_news/presentation/bloc/news_feed/auth/auth_event.dart';
import 'firebase_options.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RemoteNewsFeedBloc>(create: (context) => get()..add(const GetNewsFeed())),
          BlocProvider<AuthBloc>(create: (context) => get()..add(AuthCheckEvent()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          onGenerateRoute: AppRoutes.routes,
          home: const Wrapper(),
        ));
  }
}
