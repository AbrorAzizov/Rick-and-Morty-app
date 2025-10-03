 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_mort_test/features/home/bloc/home_event.dart';
import 'package:rick_and_mort_test/features/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc() : super(HomeInitial()){
    on<FetchCharacters>(_onFetchCharacters);
  }
}

Future<void> _onFetchCharacters(
    FetchCharacters event ,Emitter<HomeState> emit )async{
  emit(HomeStateLoading());
}