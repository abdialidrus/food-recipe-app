import 'package:food_recipe/core/error/exceptions.dart';
import 'package:food_recipe/features/splash_screen/data/datasources/auth_status_local_data_source.dart';
import 'package:food_recipe/features/splash_screen/domain/entities/auth_status.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:food_recipe/features/splash_screen/domain/repositories/auth_status_repository.dart';

class AuthStatusRepositoryImpl implements AuthStatusRepository {
  final AuthStatusLocalDataSource localDataSource;

  AuthStatusRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, AuthStatus>> getUserAuthenticationStatus() async {
    try {
      final authStatus = await localDataSource.getAuthStatus();
      return Right(authStatus);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
