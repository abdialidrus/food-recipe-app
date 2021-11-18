import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/features/recipe_list/presentation/pages/food_recipe_list_page.dart';
import 'package:food_recipe/features/splash_screen/presentation/bloc/splash_screen_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashScreenBloc splashScreenBloc;

  @override
  void initState() {
    splashScreenBloc = BlocProvider.of<SplashScreenBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    splashScreenBloc.add(GetAuthStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashScreenBloc, SplashScreenState>(
      builder: (context, state) {
        if (state is Loading) {
          return BuildSplashScreen();
        } else if (state is Loaded) {
          if (state.authStatus.isUserAuthenticated) {
            return FoodRecipeListPage();
          } else {
            return const Center(child: Text('unauthorized'));
          }
        } else {
          return const Center(child: Text('error'));
        }
      },
    );
  }
}

class BuildSplashScreen extends StatelessWidget {
  const BuildSplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade800,
      child: const Center(
        child: Image(
          image: AssetImage('graphics/recipe.png'),
        ),
      ),
    );
  }
}
