part of 'food_recipe_detail_bloc.dart';

abstract class FoodRecipeDetailEvent extends Equatable {
  const FoodRecipeDetailEvent();

  @override
  List<Object> get props => [];
}

class GetFoodRecipeDetailEvent extends FoodRecipeDetailEvent {
  final int id;

  const GetFoodRecipeDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
