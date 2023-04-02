import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cat_trivia/data/cache_repository.dart';
import 'package:cat_trivia/data/cat_trivia_repository.dart';
import 'package:cat_trivia/features/cat_fact/bloc/cat_fact_event.dart';
import 'package:cat_trivia/features/cat_fact/bloc/cat_fact_state.dart';
import 'package:cat_trivia/models/cat_fact.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  final CatTriviaRepository catTriviaRepository;
  final CacheRepository cacheRepository;

  CatFactBloc(
      {required this.catTriviaRepository, required this.cacheRepository})
      : super(CatFactInitial()) {
    on<CatFactRequested>(_onCatFactRequested);
  }

  Future<void> _onCatFactRequested(
      CatFactRequested event, Emitter<CatFactState> emit) async {
    emit(CatFactLoadInProgress());
    try {
      final CatFact catFact = await catTriviaRepository.getRandomCatFact();
      final String catImageUrl = await catTriviaRepository.getRandomCatImage();
      await cacheRepository.saveCatFact(catFact);
      emit(CatFactLoadSuccess(catFact: catFact, catImageUrl: catImageUrl));
    } catch (e) {
      print("error = $e");
      emit(CatFactLoadFailure());
    }
  }
}
