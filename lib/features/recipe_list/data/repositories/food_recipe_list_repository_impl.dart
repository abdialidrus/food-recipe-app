import 'package:food_recipe/core/error/exceptions.dart';
import 'package:food_recipe/core/network/network_info.dart';
import 'package:food_recipe/features/recipe_list/data/datasources/food_recipe_list_remote_data_source.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:food_recipe/features/recipe_list/domain/repositories/food_recipe_list_repository.dart';

typedef Future<FoodRecipeList> _FoodRecipeListGetter();

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
    return await _getRecipes(() {
      return remoteDataSource.getFoodRecipeList(page, query);
    });
  }

  Future<Either<Failure, FoodRecipeList>> _getRecipes(
    _FoodRecipeListGetter getFoodRecipeList,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRecipes = await getFoodRecipeList();
        return Right(remoteRecipes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
