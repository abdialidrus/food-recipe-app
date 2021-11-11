import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe.dart';

abstract class FoodRecipeRepository {
  Future<Either<Failure, FoodRecipe>> getFoodRecipeList(int page, String query);
}
