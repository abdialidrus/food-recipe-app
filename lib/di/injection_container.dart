import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:food_recipe/features/recipe_detail/data/datasources/food_recipe_detail_data_source.dart';
import 'package:food_recipe/features/recipe_detail/data/repositories/food_recipe_detail_repository_impl.dart';
import 'package:food_recipe/features/recipe_detail/domain/repositories/food_recipe_detail_repository.dart';
import 'package:food_recipe/features/recipe_detail/domain/usecases/get_food_recipe_detail.dart';
import 'package:food_recipe/features/recipe_detail/presentation/bloc/food_recipe_detail_bloc.dart';
import 'package:food_recipe/features/recipe_list/data/datasources/food_recipe_list_local_data_source.dart';
import 'package:food_recipe/features/recipe_list/data/datasources/food_recipe_list_remote_data_source.dart';
import 'package:food_recipe/features/recipe_list/data/repositories/food_recipe_list_repository_impl.dart';
import 'package:food_recipe/features/recipe_list/domain/repositories/food_recipe_list_repository.dart';
import 'package:food_recipe/features/recipe_list/domain/usecases/get_food_recipe_list.dart';
import 'package:food_recipe/features/recipe_list/presentation/bloc/food_recipe_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Food Recipe List
  // Bloc
  sl.registerFactory(() => FoodRecipeListBloc(getFoodRecipeList: sl()));
  // Use cases
  sl.registerLazySingleton(() => GetFoodRecipeList(sl()));
  // Repository
  sl.registerLazySingleton<FoodRecipeListRepository>(() =>
      FoodRecipeListRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  // Data sources
  sl.registerLazySingleton<FoodRecipeListRemoteDataSource>(
      () => FoodRecipeListRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<FoodRecipeListLocalDataSource>(
      () => FoodRecipeListLocalDataSourceImpl());

  //! Features - Food Recipe Detail
  // BloC
  sl.registerFactory(() => FoodRecipeDetailBloc(getFoodRecipeDetail: sl()));
  // Use cases
  sl.registerLazySingleton(() => GetFoodRecipeDetail(sl()));
  // Repository
  sl.registerLazySingleton<FoodRecipeDetailRepository>(() =>
      FoodRecipeDetailRepositoryImpl(
          remoteDataSource: sl(), networkInfo: sl()));
  // Data sources
  sl.registerLazySingleton<FoodRecipeDetailRemoteDataSource>(
      () => FoodRecipeDetailRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
