import 'package:cat_trivia/data/cat_trivia_repository.dart';
import 'package:cat_trivia/features/cat_fact/bloc/cat_fact_bloc.dart';
import 'package:cat_trivia/features/cat_fact/bloc/cat_fact_event.dart';
import 'package:cat_trivia/features/fact_history/bloc/fact_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/cat_fact/cat_fact_page.dart';
import 'features/fact_history/fact_history_page.dart';

class AppRouter {
  late final GoRouter goRouter;
  final CatTriviaRepository catTriviaRepository;

  AppRouter({required this.catTriviaRepository}) {
    goRouter = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            final catFactBloc =
                CatFactBloc(catTriviaRepository: catTriviaRepository);
            catFactBloc.add(
                CatFactRequested()); // Add the initial CatFactRequested event
            return MaterialPage<void>(
              key: state.pageKey,
              child: BlocProvider.value(
                value: catFactBloc,
                child: const CatFactPage(),
              ),
            );
          },
        ),
        GoRoute(
          path: '/fact-history',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: BlocProvider(
              create: (_) => FactHistoryCubit(catTriviaRepository),
              child: const FactHistoryPage(),
            ),
          ),
        ),
      ]
    );
  }
}
