import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/features/recipe_detail/domain/entities/food_recipe_detail.dart';
import 'package:food_recipe/features/recipe_detail/presentation/bloc/food_recipe_detail_bloc.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';
import 'package:food_recipe/features/recipe_list/presentation/widgets/loading_widget.dart';

class FoodRecipeDetailPage extends StatefulWidget {
  final FoodRecipe foodRecipe;

  const FoodRecipeDetailPage({Key? key, required this.foodRecipe})
      : super(key: key);

  @override
  _FoodRecipeDetailPageState createState() => _FoodRecipeDetailPageState();
}

class _FoodRecipeDetailPageState extends State<FoodRecipeDetailPage> {
  late FoodRecipeDetailBloc foodRecipeDetailBloc;

  @override
  void initState() {
    foodRecipeDetailBloc = BlocProvider.of<FoodRecipeDetailBloc>(context);
    foodRecipeDetailBloc.add(GetFoodRecipeDetailEvent(widget.foodRecipe.pk));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodRecipe.title),
      ),
      body: BlocBuilder<FoodRecipeDetailBloc, FoodRecipeDetailState>(
        builder: (context, state) {
          if (state is Loading) {
            return const LoadingWidget();
          } else if (state is Error) {
            return Center(child: Text(state.message));
          } else if (state is Loaded) {
            return RecipeData(
              recipeDetail: state.recipeDetail,
            );
          } else {
            return const Center(child: Text('unexpected error'));
          }
        },
      ),
    );
  }
}

class RecipeData extends StatelessWidget {
  final FoodRecipeDetail recipeDetail;
  const RecipeData({Key? key, required this.recipeDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 300.0,
            imageUrl: recipeDetail.featuredImage,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        recipeDetail.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Row(
                      children: [
                        const Icon(Icons.star),
                        Text('${recipeDetail.rating}')
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.person),
                    Text(
                      'by ${recipeDetail.publisher}',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'updated at ${recipeDetail.dateUpdated}',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ingredients',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipeDetail.ingredients.length,
                      itemBuilder: (context, index) {
                        return Text(
                          '\u2022 ${recipeDetail.ingredients[index]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
