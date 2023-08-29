import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/auth/auth_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/auth/auth_event.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) => ProfileScreen(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          SignedOutAction((context) {
            Navigator.pop(context);
            BlocProvider.of<AuthBloc>(context).add(AuthCheckEvent());
          })
        ],
      );
}
