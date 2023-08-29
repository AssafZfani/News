import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/constants/constants.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/auth/auth_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/auth/auth_event.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context) => SignInScreen(
        providers: [GoogleProvider(clientId: clientId)],
        actions: [
          AuthStateChangeAction((context, state) {
            if(state is SignedIn) {
              User? user = state.user;
              /*await DatabaseService(uid: user.uid).updateUserData(user.email, user.displayName, user.photoURL, "en", "light");*/
              BlocProvider.of<AuthBloc>(context).add(AuthCheckEvent());
            } else if (state is UserCreated) {
              User? user = state.credential.user;
              /*await DatabaseService(uid: user.uid).updateUserData(user.email, user.displayName, user.photoURL, "en", "light");*/
              BlocProvider.of<AuthBloc>(context).add(AuthCheckEvent());
            }
          }),
        ],
      );
}
