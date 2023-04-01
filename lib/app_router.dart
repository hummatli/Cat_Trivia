import 'package:cat_trivia/bloc/cat_fact/cat_fact_bloc.dart';
import 'package:cat_trivia/bloc/cat_fact/cat_fact_event.dart';
import 'package:cat_trivia/bloc/fact_history_cubit/fact_history_cubit.dart';
import 'package:cat_trivia/screens/error_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/main_screen.dart';
import 'screens/fact_history_screen.dart';
import 'repository/cat_trivia_repository.dart';

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
                  child: const MainScreen(),
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
                  child: const FactHistoryScreen()),
            ),
          ),
        ],
        errorPageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: ErrorPage(error: state.error),
            ));
  }
}
