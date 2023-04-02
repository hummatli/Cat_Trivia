import 'package:cat_trivia/api/cat_fact_service.dart';
import 'package:cat_trivia/models/cat_fact.dart';
import 'package:hive/hive.dart';
import 'cat_trivia_repository.dart';

class CatTriviaRepositoryImpl implements CatTriviaRepository {
  final CatFactService catFactService;
  final String _hiveBoxName = 'catFacts';
  final String _catImageUrl = 'https://cataas.com/cat';

  CatTriviaRepositoryImpl({required this.catFactService});

  @override
  Future<CatFact> getRandomCatFact() async {
    final catFacts = await catFactService.getRandomCatFacts();
    return catFacts[_randomIndex(catFacts.length)];
  }

  @override
  Future<String> getRandomCatImage() async {
    return '$_catImageUrl?time=${DateTime.now().millisecondsSinceEpoch}'; // Append cache-busting query parameter
  }

  @override
  Future<void> saveCatFact(CatFact fact) async {
    final box = await Hive.openBox<CatFact>(_hiveBoxName);
    await box.add(fact);
  }

  @override
  Future<List<CatFact>> getSavedCatFacts() async {
    final box = await Hive.openBox<CatFact>(_hiveBoxName);
    return box.values.toList();
  }

  int _randomIndex(int max) => DateTime.now().millisecondsSinceEpoch % max;
}
