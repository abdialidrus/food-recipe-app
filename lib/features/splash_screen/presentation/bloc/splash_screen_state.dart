part of 'splash_screen_bloc.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class Loading extends SplashScreenState {}

class Loaded extends SplashScreenState {
  final AuthStatus authStatus;

  const Loaded({required this.authStatus});

  @override
  List<Object> get props => [authStatus];
}

class Error extends SplashScreenState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
