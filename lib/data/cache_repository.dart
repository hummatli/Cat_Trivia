import 'package:cat_trivia/models/cat_fact.dart';

abstract class CacheRepository {
  Future<void> saveCatFact(CatFact fact);
  Future<List<CatFact>> getSavedCatFacts();
}