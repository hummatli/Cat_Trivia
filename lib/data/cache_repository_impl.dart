import 'package:cat_trivia/data/cache_repository.dart';
import 'package:cat_trivia/models/cat_fact.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheRepositoryImpl implements CacheRepository {
  final Box<CatFact> catFactsBox;

  CacheRepositoryImpl({required this.catFactsBox});

  @override
  Future<void> saveCatFact(CatFact fact) async {
    await catFactsBox.add(fact);
  }

  @override
  Future<List<CatFact>> getSavedCatFacts() async {
    return catFactsBox.values.toList();
  }
}