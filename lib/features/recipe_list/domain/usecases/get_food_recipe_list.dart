import 'package:equatable/equatable.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';
import 'package:food_recipe/features/recipe_list/domain/repositories/food_recipe_list_repository.dart';

class GetFoodRecipeList implements UseCase<List<FoodRecipe>, Params> {
  final FoodRecipeListRepository repository;

  GetFoodRecipeList(this.repository);

  @override
  Future<Either<Failure, List<FoodRecipe>>?> call(Params params) async {
    return await repository.getFoodRecipeList(params.page, params.query);
  }
}

class Params extends Equatable {
  final int page;
  final String query;

  const Params(this.page, this.query);

  @override
  List<Object?> get props => [page, query];
}
