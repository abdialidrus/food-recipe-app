import 'package:food_recipe/core/error/exceptions.dart';
import 'package:food_recipe/features/recipe_list/data/tables/food_recipe_table.dart';
import 'package:hive/hive.dart';

abstract class FoodRecipeListLocalDataSource {
  Future<List<FoodRecipeTable>> getFoodRecipes(String query);
  Future<void> saveFoodRecipe(FoodRecipeTable foodRecipeTable);
}

class FoodRecipeListLocalDataSourceImpl extends FoodRecipeListLocalDataSource {
  @override
  Future<List<FoodRecipeTable>> getFoodRecipes(String query) async {
    final Box<FoodRecipeTable>? recipeBox = await Hive.openBox('recipeBox');
    List<FoodRecipeTable> recipes = [];
    if (query.contains('')) {
      if (recipeBox != null) {
        final recipeIds = recipeBox.keys;
        for (var recipeId in recipeIds) {
          final recipe = recipeBox.get(recipeId);
          if (recipe != null) {
            recipes.add(recipe);
          }
        }
        return recipes;
      } else {
        throw CacheException();
      }
    } else {
      var filteredRecipes =
          recipeBox!.values.where((recipe) => recipe.title.contains(query));
      if (filteredRecipes.isNotEmpty) {
        for (var recipe in filteredRecipes) {
          recipes.add(recipe);
        }
        return recipes;
      } else {
        throw CacheException();
      }
    }
  }

  @override
  Future<void> saveFoodRecipe(FoodRecipeTable foodRecipeTable) async {
    final recipeBox = await Hive.openBox('recipeBox');
    await recipeBox.put(foodRecipeTable.pk, foodRecipeTable);
  }
}
