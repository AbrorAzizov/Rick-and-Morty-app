import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/domain/entity/character.dart';
import '../domain/repo/favourite_repo_imp.dart';
import 'favourite_state.dart';


class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo repo;

  FavoritesCubit(this.repo) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    final result = await repo.getFavorites();
    result.fold(
          (error) => emit(FavoritesError(error)),
          (favorites) => emit(FavoritesLoaded(favorites)),
    );
  }

  Future<void> toggleFavorite(Character character) async {
    if (repo.isFavorite(character.id)) {
      await repo.removeFavorite(character.id);
    } else {
      await repo.addFavorite(character);
    }
    loadFavorites();
  }

  Future<void> deleteFavorite(Character character) async {
    await repo.removeFavorite(character.id);

  }
  bool isFavorite(int id) => repo.isFavorite(id);
}
