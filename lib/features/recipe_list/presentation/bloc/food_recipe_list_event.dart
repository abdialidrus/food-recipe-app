part of 'food_recipe_list_bloc.dart';

abstract class FoodRecipeListEvent extends Equatable {
  const FoodRecipeListEvent();

  @override
  List<Object> get props => [];
}

class GetFoodRecipeList extends FoodRecipeListEvent {
  final int page;
  final int query;

  const GetFoodRecipeList(this.page, this.query);

  @override
  List<Object> get props => [page, query];
}
