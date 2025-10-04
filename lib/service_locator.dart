import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'features/home/data/repository/character_repo_imp.dart';
import 'features/home/data/service/character_servise.dart';
import 'features/home/domain/repo/character_repository.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: "https://rickandmortyapi.com/api/")));

  // Service
  sl.registerLazySingleton<CharacterService>(() => CharacterService());

  // Repository implementation
  sl.registerLazySingleton<CharacterRepo>(
        () => CharacterRepoImp(service: sl<CharacterService>()),
  );
}
