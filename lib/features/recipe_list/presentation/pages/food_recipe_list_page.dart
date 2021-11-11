import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';
import 'package:food_recipe/features/recipe_list/presentation/bloc/food_recipe_list_bloc.dart';
import 'package:food_recipe/features/recipe_list/presentation/widgets/loading_widget.dart';

class FoodRecipeListPage extends StatefulWidget {
  const FoodRecipeListPage({Key? key}) : super(key: key);

  @override
  _FoodRecipeListPageState createState() => _FoodRecipeListPageState();
}

class _FoodRecipeListPageState extends State<FoodRecipeListPage> {
  @override
  void initState() {
    const page = 1;
    const query = '';
    BlocProvider.of<FoodRecipeListBloc>(context)
        .add(const GetFoodRecipeListEvent(page, query));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Recipe'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<FoodRecipeListBloc, FoodRecipeListState>(
              builder: (context, state) {
            if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Error) {
              return Text(state.message);
            } else if (state is Loaded) {
              return RecipeList(
                recipeList: state.recipeList.result,
              );
            } else {
              return const Text('unexpected error');
            }
          }),
        ),
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  final List<FoodRecipe> recipeList;

  const RecipeList({Key? key, required this.recipeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipeList.length,
      itemBuilder: (context, index) {
        return Center(
            child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      recipeList[index].featuredImage,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(recipeList[index].title),
                subtitle: Text(recipeList[index].publisher),
              )
            ],
          ),
        ));
      },
    );
  }
}
