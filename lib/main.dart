import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rick_and_mort_test/features/home/data/model/character_model.dart';
import 'package:rick_and_mort_test/service_locator.dart';

import 'features/chosen/bloc/favourite_cubit.dart';
import 'features/chosen/data/repository/favourite_repo.dart';

import 'features/home/bloc/home_bloc.dart';
import 'features/home/bloc/theme/theme_cubit.dart';
import 'features/home/domain/repo/character_repository.dart';
import 'features/home/view/home_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoritesCubit(sl<FavoritesRepo>()),),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => CharacterBloc(sl<CharacterRepo>())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Rick and Morty',
            themeMode: themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          );

        },
      ),
    );
  }

}

