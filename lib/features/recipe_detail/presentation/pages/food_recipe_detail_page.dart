import 'package:flutter/material.dart';

class FoodRecipeDetailPage extends StatefulWidget {
  const FoodRecipeDetailPage({Key? key}) : super(key: key);

  @override
  _FoodRecipeDetailPageState createState() => _FoodRecipeDetailPageState();
}

class _FoodRecipeDetailPageState extends State<FoodRecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Recipe Detail'),
      ),
    );
  }
}
