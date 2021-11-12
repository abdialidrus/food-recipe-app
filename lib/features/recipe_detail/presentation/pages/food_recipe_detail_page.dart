import 'package:flutter/material.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';

class FoodRecipeDetailPage extends StatefulWidget {
  final FoodRecipe foodRecipe;

  const FoodRecipeDetailPage({Key? key, required this.foodRecipe})
      : super(key: key);

  @override
  _FoodRecipeDetailPageState createState() => _FoodRecipeDetailPageState();
}

class _FoodRecipeDetailPageState extends State<FoodRecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodRecipe.title),
      ),
    );
  }
}
