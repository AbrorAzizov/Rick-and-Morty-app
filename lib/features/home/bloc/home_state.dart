
import '../domain/entity/character.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class  HomeStateLoading extends HomeState {}


class TransactionStateLoaded extends HomeState {
  final List<Character> characters;
  final bool hasMore ;
  final int currentPage;

  TransactionStateLoaded({required this.characters, required this.hasMore,  this.currentPage = 1});
}
class TransactionStateError extends HomeState {
  final String message;

  TransactionStateError(this.message);
}
