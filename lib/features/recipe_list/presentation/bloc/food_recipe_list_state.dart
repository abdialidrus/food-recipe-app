part of 'food_recipe_list_bloc.dart';

abstract class FoodRecipeListState extends Equatable {
  const FoodRecipeListState();
  
  @override
  List<Object> get props => [];
}

class FoodRecipeListInitial extends FoodRecipeListState {}
