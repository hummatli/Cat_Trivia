import 'package:cat_trivia/api/cat_fact_service.dart';
import 'package:cat_trivia/data/cache_repository.dart';
import 'package:cat_trivia/data/cache_repository_impl.dart';
import 'package:cat_trivia/data/cat_trivia_repository.dart';
import 'package:cat_trivia/data/cat_trivia_repository_impl.dart';
import 'package:cat_trivia/models/cat_fact.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter<CatFact>(CatFactAdapter());
  final catFactsBox = await Hive.openBox<CatFact>('catFacts');

  // Services
  getIt.registerLazySingleton(() => CatFactService.create());

  // Repositories
  getIt.registerLazySingleton<CatTriviaRepository>(
        () => CatTriviaRepositoryImpl(catFactService: getIt()),
  );
  getIt.registerLazySingleton<CacheRepository>(() {
    return CacheRepositoryImpl(catFactsBox: catFactsBox);
  });
}
