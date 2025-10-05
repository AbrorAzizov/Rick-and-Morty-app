import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../model/character_model.dart';
import '../../domain/entity/paginated_characters.dart';
import '../../domain/repo/character_repository.dart';
import '../service/character_servise.dart';

class CharacterRepoImp implements CharacterRepo {
  final CharacterService service;
  final Box<CharacterModel> characterBox;

  CharacterRepoImp({
    required this.service,
    required this.characterBox,
  });

  @override
  Future<Either<String, PaginatedCharacters>> fetchCharacters(int page) async {
    try {

      final result = await service.fetchCharacters(page);

      
      await characterBox.clear();
      for (var c in result.characters) {
        characterBox.add(CharacterModel.fromEntity(c));
      }

      return Right(result);
    } catch (e) {

      if (characterBox.isNotEmpty) {
        final cached = characterBox.values.map((m) => m.toEntity()).toList();


        return Right(
          PaginatedCharacters(
            characters: cached,
            hasMore: false,
            currentPage: 1,
          ),
        );
      }
      return Left("Unexpected error: $e");
    }
  }

  @override
  Future<Either<String, PaginatedCharacters>> fetchMoreCharacters(int page) async {
    try {
      final result = await service.fetchCharacters(page + 1);


      for (var c in result.characters) {
        characterBox.add(CharacterModel.fromEntity(c));
      }

      return Right(result);
    } catch (e) {
      return Left("Unexpected error: $e");
    }
  }
}
