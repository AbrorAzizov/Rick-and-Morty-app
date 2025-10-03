import 'character.dart';

class PaginatedCharacters {
  final List<Character> characters;
  final bool hasMore;
  final int currentPage;

  PaginatedCharacters({
    required this.characters,
    required this.hasMore,
    required this.currentPage,
  });
}