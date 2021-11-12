import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:food_recipe/features/recipe_detail/domain/entities/food_recipe_detail.dart';

abstract class FoodRecipeDetailRepository {
  Future<Either<Failure, FoodRecipeDetail>> getFoodRecipeDetail(int id);
}
