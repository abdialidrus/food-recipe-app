import 'package:equatable/equatable.dart';

class FoodRecipeList extends Equatable {
  final int count;
  final String next;
  final String previous;
  final List<FoodRecipe> result;

  const FoodRecipeList({
    required this.count,
    required this.next,
    required this.previous,
    required this.result,
  });

  @override
  List<Object?> get props => [count, next, previous, result];
}

class FoodRecipe extends Equatable {
  final int pk;
  final String title;
  final String publisher;
  final String featuredImage;

  const FoodRecipe({
    required this.pk,
    required this.title,
    required this.publisher,
    required this.featuredImage,
  });

  @override
  List<Object?> get props => [
        pk,
        title,
        publisher,
        featuredImage,
      ];

  factory FoodRecipe.fromJson(Map<String, dynamic> json) {
    return FoodRecipe(
        pk: json['pk'],
        title: json['title'],
        publisher: json['publisher'],
        featuredImage: json['featured_image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'pk': pk,
      'title': title,
      'publisher': publisher,
      'featured_image': featuredImage
    };
  }
}
