part of 'food_recipe_detail_bloc.dart';

abstract class FoodRecipeDetailState extends Equatable {
  const FoodRecipeDetailState();

  @override
  List<Object> get props => [];
}

class Initial extends FoodRecipeDetailState {}

class Loading extends FoodRecipeDetailState {}

class Loaded extends FoodRecipeDetailState {
  final FoodRecipeDetail recipeDetail;

  const Loaded({required this.recipeDetail});
}

class Error extends FoodRecipeDetailState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
