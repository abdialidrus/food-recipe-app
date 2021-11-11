import 'dart:convert';

import 'package:food_recipe/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:food_recipe/features/recipe_list/data/models/food_recipe_list_model.dart';

abstract class FoodRecipeListRemoteDataSource {
  /// Calls the https://food2fork.ca/api/recipe/search/ endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<FoodRecipeListModel> getFoodRecipeList(int page, String query);
}

class FoodRecipeListRemoteDataSourceImpl
    implements FoodRecipeListRemoteDataSource {
  final http.Client client;

  FoodRecipeListRemoteDataSourceImpl({required this.client});

  @override
  Future<FoodRecipeListModel> getFoodRecipeList(int page, String query) async {
    final uri = Uri.parse(
        'https://food2fork.ca/api/recipe/search/?page=$page&query=$query');

    final response = await client.get(uri, headers: {
      'Authorization': 'Token 9c8b06d329136da358c2d00e76946b0111ce2c48'
    });

    if (response.statusCode == 200) {
      return FoodRecipeListModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
