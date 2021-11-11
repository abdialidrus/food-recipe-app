import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/features/recipe_list/presentation/pages/food_recipe_list_page.dart';
import 'features/recipe_list/presentation/bloc/food_recipe_list_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.red.shade800,
          secondary: Colors.red.shade600,
        ),
      ),
      home: buildBody(context),
    );
  }

  BlocProvider<FoodRecipeListBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<FoodRecipeListBloc>(),
      child: const FoodRecipeListPage(),
    );
  }
}
