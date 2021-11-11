import 'package:equatable/equatable.dart';

class FoodRecipeListModel extends Equatable {
  final int count;
  final String next;
  final String previous;
  final List<FoodRecipeModel> result;

  const FoodRecipeListModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.result,
  });

  factory FoodRecipeListModel.fromJson(Map<String, dynamic> json) {
    var recipeListFromJson = json['result'] as List;
    List<FoodRecipeModel> recipeList =
        recipeListFromJson.map((i) => FoodRecipeModel.fromJson(i)).toList();

    return FoodRecipeListModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      result: recipeList,
    );
  }

  @override
  List<Object?> get props => [count, next, previous, result];
}

class FoodRecipeModel extends Equatable {
  final int pk;
  final String title;
  final String publisher;
  final String featuredImage;

  const FoodRecipeModel(
      {required this.pk,
      required this.title,
      required this.publisher,
      required this.featuredImage});

  factory FoodRecipeModel.fromJson(Map<String, dynamic> json) {
    return FoodRecipeModel(
        pk: json['pk'],
        title: json['title'],
        publisher: json['publisher'],
        featuredImage: json['featured_image']);
  }

  @override
  List<Object?> get props => [pk, title, publisher, featuredImage];
}
