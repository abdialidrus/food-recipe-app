import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';
import 'package:food_recipe/features/recipe_list/domain/usecases/get_food_recipe_list.dart';

part 'food_recipe_list_event.dart';
part 'food_recipe_list_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class FoodRecipeListBloc
    extends Bloc<FoodRecipeListEvent, FoodRecipeListState> {
  final GetFoodRecipeList getFoodRecipeList;

  FoodRecipeListBloc({required this.getFoodRecipeList}) : super(Loading());

  @override
  Stream<FoodRecipeListState> mapEventToState(
      FoodRecipeListEvent event) async* {
    if (event is GetFoodRecipeListEvent) {
      final page = event.page;
      final query = event.query;

      yield Loading();
      final failureOrRecipeList = await getFoodRecipeList(Params(page, query));
      yield* _eitherLoadedOrErrorState(failureOrRecipeList!);
    }
  }

  Stream<FoodRecipeListState> _eitherLoadedOrErrorState(
    Either<Failure, FoodRecipeList> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (recipeList) => Loaded(recipeList: recipeList),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
