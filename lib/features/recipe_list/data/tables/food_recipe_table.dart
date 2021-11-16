import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';
import 'package:hive/hive.dart';

part 'food_recipe_table.g.dart';

@HiveType(typeId: 0)
class FoodRecipeTable extends FoodRecipe {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String publisher;

  @HiveField(3)
  final String featuredImage;

  const FoodRecipeTable(
      {required this.pk,
      required this.title,
      required this.publisher,
      required this.featuredImage})
      : super(
            pk: pk,
            title: title,
            publisher: publisher,
            featuredImage: featuredImage);

  factory FoodRecipeTable.fromFoodRecipeEntity(FoodRecipe foodRecipe) {
    return FoodRecipeTable(
      pk: foodRecipe.pk,
      title: foodRecipe.title,
      publisher: foodRecipe.publisher,
      featuredImage: foodRecipe.featuredImage,
    );
  }
}
