import 'package:cat_trivia/models/cat_fact.dart';
import 'package:cat_trivia/repository/cat_trivia_repository_impl.dart';
import 'package:cat_trivia/services/cat_fact_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app_router.dart';
import 'repository/cat_trivia_repository.dart';

void main() {
  Hive.initFlutter();
  Hive.registerAdapter<CatFact>(CatFactAdapter());

  final catFactService = CatFactService.create();

  final catTriviaRepository = CatTriviaRepositoryImpl(
      catFactService: catFactService
  );

  final appRouter = AppRouter(catTriviaRepository: catTriviaRepository);

  runApp(MyApp(goRouter: appRouter.goRouter));
}

class MyApp extends StatelessWidget {
  final GoRouter goRouter;

  MyApp({Key? key, required this.goRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      title: 'Cat Trivia',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
