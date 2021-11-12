import 'package:equatable/equatable.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/features/recipe_detail/domain/entities/food_recipe_detail.dart';
import 'package:food_recipe/features/recipe_detail/domain/repositories/food_recipe_detail_repository.dart';

class GetFoodRecipeDetail implements UseCase<FoodRecipeDetail, Params> {
  final FoodRecipeDetailRepository repository;

  GetFoodRecipeDetail(this.repository);

  @override
  Future<Either<Failure, FoodRecipeDetail>?> call(Params params) async {
    return await repository.getFoodRecipeDetail(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params(this.id);

  @override
  List<Object?> get props => [id];
}
