import '../domain/entity/character.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;
  final bool hasMore;
  final int currentPage;

  CharacterLoaded({
    required this.characters,
    required this.hasMore,
    required this.currentPage,
  });

  CharacterLoaded copyWith({
    List<Character>? characters,
    bool? hasMore,
    int? currentPage,
  }) {
    return CharacterLoaded(
        characters: characters ?? this.characters,
        hasMore: hasMore ?? this.hasMore,
        currentPage: currentPage ?? this.currentPage);
  }
}

class CharacterError extends CharacterState {
  final String message;

  CharacterError(this.message);
}
