import 'dart:convert';

import 'package:food_recipe/core/error/exceptions.dart';
import 'package:food_recipe/features/recipe_detail/data/models/food_recipe_detail_model.dart';
import 'package:http/http.dart' as http;

abstract class FoodRecipeDetailRemoteDataSource {
  /// Calls the https://food2fork.ca/api/recipe/get/?id= endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<FoodRecipeDetailModel> getFoodRecipeDetail(int id);
}

class FoodRecipeDetailRemoteDataSourceImpl
    implements FoodRecipeDetailRemoteDataSource {
  final http.Client client;

  FoodRecipeDetailRemoteDataSourceImpl({required this.client});

  @override
  Future<FoodRecipeDetailModel> getFoodRecipeDetail(int id) async {
    final uri = Uri.parse('https://food2fork.ca/api/recipe/get/?id=$id');

    final response = await client.get(uri, headers: {
      'Authorization': 'Token 9c8b06d329136da358c2d00e76946b0111ce2c48'
    });

    if (response.statusCode == 200) {
      return FoodRecipeDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
