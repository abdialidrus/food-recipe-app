import 'package:equatable/equatable.dart';

class AuthStatus extends Equatable {
  final bool isUserAuthenticated;

  AuthStatus({required this.isUserAuthenticated});

  @override
  List<Object?> get props => [isUserAuthenticated];
}
