part of 'food_recipe_list_bloc.dart';

abstract class FoodRecipeListEvent extends Equatable {
  const FoodRecipeListEvent();

  @override
  List<Object> get props => [];
}

class GetFoodRecipeListEvent extends FoodRecipeListEvent {
  final int page;
  final String query;

  const GetFoodRecipeListEvent(this.page, this.query);

  @override
  List<Object> get props => [page, query];
}
