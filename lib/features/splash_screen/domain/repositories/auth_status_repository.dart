import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:food_recipe/features/splash_screen/domain/entities/auth_status.dart';

abstract class AuthStatusRepository {
  Future<Either<Failure, AuthStatus>> getUserAuthenticationStatus();
}
