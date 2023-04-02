import '../models/cat_fact.dart';

abstract class CatTriviaRepository {
  Future<CatFact> getRandomCatFact();
  Future<String> getRandomCatImage();
  Future<void> saveCatFact(CatFact fact);
  Future<List<CatFact>> getSavedCatFacts();
}
