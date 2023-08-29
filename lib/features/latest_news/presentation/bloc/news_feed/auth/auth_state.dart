import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {
  final User? user;

  const AuthState({this.user});
}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(User? user) : super(user: user);
}

class AuthNotAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}
