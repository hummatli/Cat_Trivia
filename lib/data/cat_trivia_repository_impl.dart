import 'package:cat_trivia/api/cat_fact_service.dart';
import 'package:cat_trivia/models/cat_fact.dart';
import 'cat_trivia_repository.dart';

class CatTriviaRepositoryImpl implements CatTriviaRepository {
  final CatFactService catFactService;
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

  int _randomIndex(int max) => DateTime.now().millisecondsSinceEpoch % max;
}
