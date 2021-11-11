import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';

class FoodRecipeListModel extends FoodRecipeList {
  const FoodRecipeListModel({
    required int count,
    required String next,
    required String? previous,
    required List<FoodRecipe> result,
  }) : super(count: count, next: next, previous: previous, result: result);

  factory FoodRecipeListModel.fromJson(Map<String, dynamic> json) {
    var recipeListFromJson = json['results'] as List;
    List<FoodRecipe> recipeList =
        recipeListFromJson.map((i) => FoodRecipe.fromJson(i)).toList();

    return FoodRecipeListModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      result: recipeList,
    );
  }

  @override
  List<Object?> get props => [count, next, previous, result];
}
