import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';

abstract class FoodRecipeListRepository {
  Future<Either<Failure, List<FoodRecipe>>> getFoodRecipeList(
      int page, String query);
}
