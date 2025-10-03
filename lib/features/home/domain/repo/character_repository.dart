import 'package:dartz/dartz.dart';
import 'package:rick_and_mort_test/features/home/domain/entity/paginated_characters.dart';

abstract class CharacterRepo {
  Future<Either<String, PaginatedCharacters>> fetchCharacters(int page);
  Future<Either<String, PaginatedCharacters>> fetchMoreCharacters(int page);
}