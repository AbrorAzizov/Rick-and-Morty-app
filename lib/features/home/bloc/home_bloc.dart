 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_mort_test/features/home/bloc/home_event.dart';
import 'package:rick_and_mort_test/features/home/bloc/home_state.dart';

import '../domain/repo/character_repository.dart';
 class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
   final CharacterRepo repo;

   CharacterBloc(this.repo) : super(CharacterInitial()) {
     on<LoadCharacters>(_onLoadCharacters);
     on<LoadMoreCharacters>(_onLoadMoreCharacters);
   }

   Future<void> _onLoadCharacters(
       LoadCharacters event, Emitter<CharacterState> emit) async {
     emit(CharacterLoading());

     final result = await repo.fetchCharacters(event.page);

     result.fold(
           (error) => emit(CharacterError(error)),
           (data) => emit(CharacterLoaded(
         characters: data.characters,
         hasMore: data.hasMore,
         currentPage: data.currentPage,
       )),
     );
   }

   Future<void> _onLoadMoreCharacters(
       LoadMoreCharacters event, Emitter<CharacterState> emit) async {
     if (state is! CharacterLoaded) return;
     final currentState = state as CharacterLoaded;

     if (!currentState.hasMore) return;

     final result = await repo.fetchMoreCharacters(event.currentPage);

     result.fold(
           (error) => emit(CharacterError(error)),
           (data) => emit(
         currentState.copyWith(
           characters: [...currentState.characters, ...data.characters],
           currentPage: data.currentPage,
           hasMore: data.hasMore,
         ),
       ),
     );
   }
 }