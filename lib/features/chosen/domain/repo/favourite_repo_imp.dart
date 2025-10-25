import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../../../home/data/model/character_model.dart';
import '../../../home/domain/entity/character.dart';
import '../../data/repository/favourite_repo.dart';

class FavoritesRepoImp implements FavoritesRepo {
  final Box<CharacterModel> favoritesBox;

  FavoritesRepoImp({required this.favoritesBox});

  @override
  Future<Either<String, List<Character>>> getFavorites() async {
    try {
      final favorites = favoritesBox.values.map((m) => m.toEntity()).toList();
      return Right(favorites);
    } catch (e) {
      return Left('Error loading favorites: $e');
    }
  }

  @override
  Future<void> addFavorite(Character character) async {
    final exists = favoritesBox.values.any((c) => c.id == character.id);
    if (!exists) {
      await favoritesBox.add(CharacterModel.fromEntity(character));
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    final key = favoritesBox.keys.firstWhere(
          (k) => favoritesBox.get(k)?.id == id,
      orElse: () => null,
    );
    if (key != null) {
      await favoritesBox.delete(key);
    }
  }

  @override
  bool isFavorite(int id) {
    return favoritesBox.values.any((c) => c.id == id);
  }

  @override
  List<Character> sortFavourites(String sortBy, List<Character> characters) {
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
    return sorted;
  }

  @override
  List<Character> searchFavourites(String query, List<Character> characters) {
    return characters
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  void loadCharacters(List<Character> characters) {

  }
}
