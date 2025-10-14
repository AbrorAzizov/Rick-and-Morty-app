import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_mort_test/features/chosen/domain/repo/favourite_repo_imp.dart';
import 'package:rick_and_mort_test/features/home/data/model/character_model.dart';

import 'features/chosen/data/repository/favourite_repo.dart';

import 'features/home/data/repository/character_repo_imp.dart';
import 'features/home/data/service/character_servise.dart';
import 'features/home/domain/repo/character_repository.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: "https://rickandmortyapi.com/api/")));

  // Service
  sl.registerLazySingleton<CharacterService>(() => CharacterService());

  final characterBox = await Hive.openBox<CharacterModel>('CharacterBox');
  final favoritesBox = await Hive.openBox<CharacterModel>('favorites');
  sl.registerSingleton<FavoritesRepo>(FavoritesRepoImp(favoritesBox: favoritesBox));


  sl.registerLazySingleton<CharacterRepo>(
        () => CharacterRepoImp(service: sl<CharacterService>(),characterBox: characterBox),
  );
}
