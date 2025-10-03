abstract class CharacterEvent {}

class LoadCharacters extends CharacterEvent {
  final int page;
  LoadCharacters({this.page = 1});
}

class LoadMoreCharacters extends CharacterEvent {
  final int currentPage;
  LoadMoreCharacters(this.currentPage);
}
