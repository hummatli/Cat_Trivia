import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/cat_fact/cat_fact_page.dart';
import 'features/fact_history/fact_history_page.dart';

class AppRouter {
  late final GoRouter goRouter;

  AppRouter() {
    goRouter = GoRouter(routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: CatFactPage(),
          );
        },
      ),
      GoRoute(
        path: '/fact-history',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
          key: state.pageKey,
          child: FactHistoryPage(),
        );
        },
      ),
    ]);
  }
}
