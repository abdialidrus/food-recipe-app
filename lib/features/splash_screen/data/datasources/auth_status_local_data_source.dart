import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:food_recipe/features/splash_screen/data/models/auth_status_model.dart';

abstract class AuthStatusLocalDataSource {
  Future<AuthStatusModel> getAuthStatus();
}

class AuthStatusLocalDataSourceImpl extends AuthStatusLocalDataSource {
  final SessionManager sessionManager;

  AuthStatusLocalDataSourceImpl({required this.sessionManager});

  @override
  Future<AuthStatusModel> getAuthStatus() async {
    await sessionManager.set('authStatus', false);
    final bool isUserAuthenticated = await sessionManager.get('authStatus');
    return AuthStatusModel(isUserAuthenticated: isUserAuthenticated);
  }
}
