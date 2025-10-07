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

  void sortFavourites (List<Character> characters, String sortBy){
    final sorted = List<Character>.from(characters);
    switch (sortBy) {
      case 'name':
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'status':
        sorted.sort((a, b) => a.status.compareTo(b.status));
        break;
      case 'species':
        sorted.sort((a, b) => a.species.compareTo(b.species));
        break;
    }
  emit(FavoritesLoaded(sorted));
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
