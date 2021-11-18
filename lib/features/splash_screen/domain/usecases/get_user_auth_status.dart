import 'package:food_recipe/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/features/recipe_detail/domain/usecases/get_food_recipe_detail.dart';
import 'package:food_recipe/features/splash_screen/domain/entities/auth_status.dart';
import 'package:food_recipe/features/splash_screen/domain/repositories/auth_status_repository.dart';

class GetUserAuthStatus extends UseCase<AuthStatus, NoParams> {
  final AuthStatusRepository repository;

  GetUserAuthStatus(this.repository);

  @override
  Future<Either<Failure, AuthStatus>?> call(NoParams params) async {
    return await repository.getUserAuthenticationStatus();
  }
}
