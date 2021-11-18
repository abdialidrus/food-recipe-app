import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:food_recipe/features/recipe_detail/domain/entities/food_recipe_detail.dart';
import 'package:food_recipe/features/recipe_detail/domain/usecases/get_food_recipe_detail.dart';

part 'food_recipe_detail_event.dart';
part 'food_recipe_detail_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class FoodRecipeDetailBloc
    extends Bloc<FoodRecipeDetailEvent, FoodRecipeDetailState> {
  final GetFoodRecipeDetail getFoodRecipeDetail;

  FoodRecipeDetailBloc({required this.getFoodRecipeDetail}) : super(Loading());

  @override
  Stream<FoodRecipeDetailState> mapEventToState(
      FoodRecipeDetailEvent event) async* {
    if (event is GetFoodRecipeDetailEvent) {
      yield Loading();
      final failureOrRecipeDetail = await getFoodRecipeDetail(Params(event.id));
      yield* _eitherLoadedOrErrorState(failureOrRecipeDetail!);
    }
  }

  Stream<FoodRecipeDetailState> _eitherLoadedOrErrorState(
    Either<Failure, FoodRecipeDetail> failureOrRecipeDetail,
  ) async* {
    yield failureOrRecipeDetail.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (recipeDetail) => Loaded(recipeDetail: recipeDetail),
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
