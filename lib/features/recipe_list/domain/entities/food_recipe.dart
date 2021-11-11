import 'package:equatable/equatable.dart';

class FoodRecipe extends Equatable {
  final int pk;
  final String title;
  final String publisher;
  final String featuredImage;

  const FoodRecipe(
    this.pk,
    this.title,
    this.publisher,
    this.featuredImage,
  );

  @override
  List<Object?> get props => [
        pk,
        title,
        publisher,
        featuredImage,
      ];

  Map<String, dynamic> toJson() {
    return {
      'pk': pk,
      'title': title,
      'publisher': publisher,
      'featured_image': featuredImage
    };
  }
}
