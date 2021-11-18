import 'package:food_recipe/features/splash_screen/domain/entities/auth_status.dart';

class AuthStatusModel extends AuthStatus {
  AuthStatusModel({required bool isUserAuthenticated})
      : super(isUserAuthenticated: isUserAuthenticated);

  @override
  List<Object?> get props => [isUserAuthenticated];
}
