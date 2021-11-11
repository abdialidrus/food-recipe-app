import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'food_recipe_list_event.dart';
part 'food_recipe_list_state.dart';

class FoodRecipeListBloc extends Bloc<FoodRecipeListEvent, FoodRecipeListState> {
  FoodRecipeListBloc() : super(FoodRecipeListInitial()) {
    on<FoodRecipeListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
