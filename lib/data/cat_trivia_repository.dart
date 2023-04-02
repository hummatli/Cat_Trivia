import '../models/cat_fact.dart';

abstract class CatTriviaRepository {
  Future<CatFact> getRandomCatFact();
  Future<String> getRandomCatImage();
}
