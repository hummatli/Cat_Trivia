import 'package:bloc/bloc.dart';
import 'package:cat_trivia/models/cat_fact.dart';
import 'package:cat_trivia/repository/cat_trivia_repository.dart';
import 'fact_history_state.dart';

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
