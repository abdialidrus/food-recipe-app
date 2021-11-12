import 'package:equatable/equatable.dart';

class FoodRecipeDetail extends Equatable {
  final int pk;
  final String title;
  final String publisher;
  final String featuredImage;
  final int rating;
  final String sourceUrl;
  final String description;
  final List<String> ingredients;
  final String dateAdded;
  final String dateUpdated;

  const FoodRecipeDetail({
    required this.pk,
    required this.title,
    required this.publisher,
    required this.featuredImage,
    required this.rating,
    required this.sourceUrl,
    required this.description,
    required this.ingredients,
    required this.dateAdded,
    required this.dateUpdated,
  });

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
