import 'package:food_recipe/core/error/exceptions.dart';
import 'package:food_recipe/core/network/network_info.dart';
import 'package:food_recipe/features/recipe_list/data/datasources/food_recipe_list_remote_data_source.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:food_recipe/features/recipe_list/domain/repositories/food_recipe_list_repository.dart';

class FoodRecipeListRepositoryImpl implements FoodRecipeListRepository {
  final FoodRecipeListRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FoodRecipeListRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, FoodRecipeList>> getFoodRecipeList(
      int page, String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRecipes =
            await remoteDataSource.getFoodRecipeList(page, query);
        return Right(remoteRecipes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
