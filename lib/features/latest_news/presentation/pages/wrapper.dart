import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/auth/auth_bloc.dart';
import 'package:news/features/latest_news/presentation/pages/authenticate/authenticate.dart';
import 'package:news/features/latest_news/presentation/pages/home/home.dart';

import '../bloc/news_feed/auth/auth_state.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthLoading) {
          return const CircularProgressIndicator();
        } else if (state is AuthAuthenticated) {
          return const Home();
        } else if (state is AuthNotAuthenticated) {
          return const Authenticate();
        } else if (state is AuthError) {
          return Text('Error: ${state.errorMessage}');
        }
        return Container();
      });
}
