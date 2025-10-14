import 'package:dartz/dartz.dart';
import 'package:rick_and_mort_test/features/home/domain/entity/character.dart';

abstract class FavoritesRepo {
  Future<Either<String, List<Character>>> getFavorites();
  Future<void> addFavorite(Character character);
  Future<void> removeFavorite(int id);
  bool isFavorite(int id);
}
