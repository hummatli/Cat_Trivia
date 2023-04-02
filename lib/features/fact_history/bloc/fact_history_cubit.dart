import 'package:bloc/bloc.dart';
import 'package:cat_trivia/data/cache_repository.dart';
import 'package:cat_trivia/features/fact_history/bloc/fact_history_state.dart';
import 'package:cat_trivia/models/cat_fact.dart';

class FactHistoryCubit extends Cubit<FactHistoryState> {
  final CacheRepository _cacheRepository;

  FactHistoryCubit(this._cacheRepository) : super(FactHistoryInitial()) {
    loadFactHistory();
  }

  Future<void> loadFactHistory() async {
    emit(FactHistoryLoadInProgress());
    try {
      final List<CatFact> factHistory =
          await _cacheRepository.getSavedCatFacts();
      emit(FactHistoryLoadSuccess(factHistory));
    } catch (_) {
      emit(FactHistoryLoadFailure());
    }
  }
}
