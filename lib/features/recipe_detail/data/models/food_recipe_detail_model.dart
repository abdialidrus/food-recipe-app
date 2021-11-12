import 'package:food_recipe/features/recipe_detail/domain/entities/food_recipe_detail.dart';

class FoodRecipeDetailModel extends FoodRecipeDetail {
  const FoodRecipeDetailModel({
    required int pk,
    required String title,
    required String publisher,
    required String featuredImage,
    required int rating,
    required String sourceUrl,
    required String description,
    required List<String> ingredients,
    required String dateAdded,
    required String dateUpdated,
  }) : super(
          pk: pk,
          title: title,
          publisher: publisher,
          featuredImage: featuredImage,
          rating: rating,
          sourceUrl: sourceUrl,
          description: description,
          ingredients: ingredients,
          dateAdded: dateAdded,
          dateUpdated: dateUpdated,
        );

  factory FoodRecipeDetailModel.fromJson(Map<String, dynamic> json) {
    var ingredientListFromJson = json['ingredients'] as List;
    List<String> ingredientList = List<String>.from(ingredientListFromJson);

    return FoodRecipeDetailModel(
      pk: json['pk'],
      title: json['title'],
      publisher: json['publisher'],
      featuredImage: json['featured_image'],
      rating: json['rating'],
      sourceUrl: json['source_url'],
      description: json['description'],
      ingredients: ingredientList,
      dateAdded: json['date_added'],
      dateUpdated: json['date_updated'],
    );
  }

  @override
  List<Object?> get props => [
        pk,
        title,
        publisher,
        featuredImage,
        rating,
        sourceUrl,
        description,
        ingredients,
        dateAdded,
        dateUpdated,
      ];
}
