import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../../../home/data/model/character_model.dart';
import '../../../home/domain/entity/character.dart';

class FavoritesRepo {
  final Box<CharacterModel> favoritesBox;

  FavoritesRepo({required this.favoritesBox});

  Future<Either<String, List<Character>>> getFavorites() async {
    try {
      final favorites = favoritesBox.values.map((m) => m.toEntity()).toList();
      return Right(favorites);
    } catch (e) {
      return Left('Error loading favorites: $e');
    }
  }

  Future<void> addFavorite(Character character) async {
    final exists = favoritesBox.values.any((c) => c.id == character.id);
    if (!exists) {
      await favoritesBox.add(CharacterModel.fromEntity(character));
    }
  }

  Future<void> removeFavorite(int id) async {
    final key = favoritesBox.keys.firstWhere(
          (k) => favoritesBox.get(k)?.id == id,
      orElse: () => null,
    );
    if (key != null) {
      await favoritesBox.delete(key);
    }
  }

  bool isFavorite(int id) {
    return favoritesBox.values.any((c) => c.id == id);
  }
}
