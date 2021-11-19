import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/features/recipe_detail/presentation/bloc/food_recipe_detail_bloc.dart';
import 'package:food_recipe/features/recipe_list/data/tables/food_recipe_table.dart';
import 'package:food_recipe/features/splash_screen/presentation/bloc/splash_screen_bloc.dart';
import 'package:food_recipe/features/splash_screen/presentation/pages/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/recipe_list/presentation/bloc/food_recipe_list_bloc.dart';
import 'di/injection_container.dart' as di;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(FoodRecipeTableAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashScreenBloc>(
            create: (_) => di.sl<SplashScreenBloc>()),
        BlocProvider<FoodRecipeListBloc>(
            create: (_) => di.sl<FoodRecipeListBloc>()),
        BlocProvider<FoodRecipeDetailBloc>(
            create: (_) => di.sl<FoodRecipeDetailBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Recipe',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.red.shade800,
            secondary: Colors.red.shade600,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
