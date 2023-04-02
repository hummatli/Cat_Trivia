import 'package:bloc/bloc.dart';
import 'package:cat_trivia/data/cat_trivia_repository.dart';
import 'package:cat_trivia/features/fact_history/bloc/fact_history_state.dart';
import 'package:cat_trivia/models/cat_fact.dart';

class FactHistoryCubit extends Cubit<FactHistoryState> {
  final CatTriviaRepository _catTriviaRepository;

  FactHistoryCubit(this._catTriviaRepository) : super(FactHistoryInitial()) {
    loadFactHistory();
  }

  Future<void> loadFactHistory() async {
    emit(FactHistoryLoadInProgress());
    try {
      final List<CatFact> factHistory =
          await _catTriviaRepository.getSavedCatFacts();
      emit(FactHistoryLoadSuccess(factHistory));
    } catch (_) {
      emit(FactHistoryLoadFailure());
    }
  }
}
