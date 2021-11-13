import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/features/recipe_detail/presentation/pages/food_recipe_detail_page.dart';
import 'package:food_recipe/features/recipe_list/domain/entities/food_recipe_list.dart';
import 'package:food_recipe/features/recipe_list/presentation/bloc/food_recipe_list_bloc.dart';
import 'package:food_recipe/features/recipe_list/presentation/widgets/loading_widget.dart';

class FoodRecipeListPage extends StatefulWidget {
  const FoodRecipeListPage({Key? key}) : super(key: key);

  @override
  _FoodRecipeListPageState createState() => _FoodRecipeListPageState();
}

class _FoodRecipeListPageState extends State<FoodRecipeListPage> {
  final _controller = TextEditingController();
  late FoodRecipeListBloc foodRecipeListBloc;
  String query = '';

  @override
  void initState() {
    const page = 1;
    query = '';
    foodRecipeListBloc = BlocProvider.of<FoodRecipeListBloc>(context);
    foodRecipeListBloc.add(GetFoodRecipeListEvent(page, query));
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
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Search recipe",
                    hintText: "Search recipe",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    query = value;
                  },
                  onSubmitted: (_) {
                    searchRecipe();
                  },
                ),
              ),
              BlocBuilder<FoodRecipeListBloc, FoodRecipeListState>(
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchRecipe() {
    foodRecipeListBloc.add(GetFoodRecipeListEvent(1, query));
  }
}

class RecipeList extends StatelessWidget {
  final List<FoodRecipe> recipeList;

  const RecipeList({Key? key, required this.recipeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: recipeList.length,
        itemBuilder: (context, index) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodRecipeDetailPage(
                        foodRecipe: recipeList[index],
                      ),
                    ),
                  );
                },
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
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
