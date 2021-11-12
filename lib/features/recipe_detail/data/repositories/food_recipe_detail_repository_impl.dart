import 'package:food_recipe/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/network/network_info.dart';
import 'package:food_recipe/features/recipe_detail/data/datasources/food_recipe_detail_data_source.dart';
import 'package:food_recipe/features/recipe_detail/domain/entities/food_recipe_detail.dart';
import 'package:food_recipe/features/recipe_detail/domain/repositories/food_recipe_detail_repository.dart';

class FoodRecipeDetailRepositoryImpl implements FoodRecipeDetailRepository {
  final FoodRecipeDetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FoodRecipeDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, FoodRecipeDetail>> getFoodRecipeDetail(int id) async {
    if (await networkInfo.isConnected) {
      final remoteRecipeDetail = await remoteDataSource.getFoodRecipeDetail(id);
      return Right(remoteRecipeDetail);
    } else {
      return Left(CacheFailure());
    }
  }
}
