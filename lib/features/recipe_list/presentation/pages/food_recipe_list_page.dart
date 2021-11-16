import 'package:cached_network_image/cached_network_image.dart';
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
  void dispose() {
    super.dispose();
    _controller.dispose();
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
                      recipeList: state.recipeList,
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

class RecipeList extends StatefulWidget {
  final List<FoodRecipe> recipeList;

  const RecipeList({Key? key, required this.recipeList}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  final _listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _listScrollController.addListener(() {
      if (_listScrollController.position.pixels >=
          _listScrollController.position.maxScrollExtent) {
        _showToast(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listScrollController.dispose();
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('you have reach the bottom of the list'),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        controller: _listScrollController,
        itemCount: widget.recipeList.length,
        itemBuilder: (context, index) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodRecipeDetailPage(
                        foodRecipe: widget.recipeList[index],
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CachedNetworkImage(
                      height: 200.0,
                      imageUrl: widget.recipeList[index].featuredImage,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            // colorFilter: const ColorFilter.mode(
                            //     Colors.red, BlendMode.colorBurn),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    ListTile(
                      title: Text(widget.recipeList[index].title),
                      subtitle: Text(widget.recipeList[index].publisher),
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
