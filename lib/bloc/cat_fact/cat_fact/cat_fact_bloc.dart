import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cat_trivia/bloc/cat_fact/cat_fact/cat_fact_event.dart';
import 'package:cat_trivia/bloc/cat_fact/cat_fact/cat_fact_state.dart';
import 'package:cat_trivia/models/cat_fact.dart';
import 'package:cat_trivia/repository/cat_trivia_repository.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  final CatTriviaRepository catTriviaRepository;

  CatFactBloc({required this.catTriviaRepository}) : super(CatFactInitial()) {
    on<CatFactRequested>(_onCatFactRequested);
  }

  Future<void> _onCatFactRequested(CatFactRequested event, Emitter<CatFactState> emit) async {
    print("Reques _onCatFactRequested 0");

    emit(CatFactLoadInProgress());

    print("Reques _onCatFactRequested");
    try {
      final CatFact catFact = await catTriviaRepository.getRandomCatFact();
      final String catImageUrl = await catTriviaRepository.getRandomCatImage();
      await catTriviaRepository.saveCatFact(catFact);
      emit(CatFactLoadSuccess(catFact: catFact, catImageUrl: catImageUrl));
    } catch (e) {
      print("error = $e");
      emit(CatFactLoadFailure());
    }
  }
}