import 'package:dio/dio.dart';
import '../../domain/entity/character.dart';
import '../../domain/entity/paginated_characters.dart';

class CharacterService {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://rickandmortyapi.com/api/"));

  Future<PaginatedCharacters> fetchCharacters(int page) async {
    final response = await dio.get("character?page=$page");
    final data = response.data;


    final characters = (data['results'] as List)
        .map((json) => Character.fromJson(json))
        .toList();


    final totalPages = data['info']['pages'];
    final hasMore = page < totalPages;

    return PaginatedCharacters(
      characters: characters,
      hasMore: hasMore,
      currentPage: page,
    );
  }
}
