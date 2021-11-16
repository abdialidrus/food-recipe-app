part of 'food_recipe_list_bloc.dart';

abstract class FoodRecipeListState extends Equatable {
  const FoodRecipeListState();

  @override
  List<Object> get props => [];
}

class Initial extends FoodRecipeListState {}

class Loading extends FoodRecipeListState {}

class Loaded extends FoodRecipeListState {
  final List<FoodRecipe> recipeList;

  const Loaded({required this.recipeList});

  @override
  List<Object> get props => [recipeList];
}

class Error extends FoodRecipeListState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
