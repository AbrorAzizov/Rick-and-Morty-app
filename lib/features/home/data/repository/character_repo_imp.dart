

import 'package:dartz/dartz.dart';

import 'package:rick_and_mort_test/features/home/data/service/character_servise.dart';
import 'package:rick_and_mort_test/features/home/domain/entity/paginated_characters.dart';
import 'package:rick_and_mort_test/features/home/domain/repo/character_repository.dart';


class CharacterRepoImp implements CharacterRepo {
  final CharacterService service;

  CharacterRepoImp({required this.service});

  @override
  Future<Either<String, PaginatedCharacters>> fetchCharacters(int page) async {
    try {
      final result = await service.fetchCharacters(page);
      return Right(result);
    } catch (e) {
      return Left("Unexpected error: $e");
    }
  }


  @override
  Future<Either<String, PaginatedCharacters>> fetchMoreCharacters(int page) async {
    try {
      final result = await service.fetchCharacters(page + 1);
      return Right(result);
    } catch (e) {
      return Left("Unexpected error: $e");
    }
  }
}