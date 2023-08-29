import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/auth/auth_event.dart';
import 'package:news/features/latest_news/presentation/bloc/news_feed/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthLoading()) {
    on<AuthEvent>(onAuthEvent);
  }

  void onAuthEvent(AuthEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final user = _auth.currentUser;

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthNotAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
