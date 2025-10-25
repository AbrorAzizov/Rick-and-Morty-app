import 'package:dartz/dartz.dart';
import 'package:rick_and_mort_test/features/home/domain/entity/character.dart';

abstract class FavoritesRepo {
  Future<Either<String, List<Character>>> getFavorites();
  Future<void> addFavorite(Character character);
  Future<void> removeFavorite(int id);
  List<Character> sortFavourites(String sortBy, List<Character> characters);
  List<Character> searchFavourites(String query, List<Character> characters);
  void loadCharacters(List<Character> characters);
  bool isFavorite(int id);
}
