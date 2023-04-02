import 'package:cat_trivia/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();

  final appRouter = AppRouter();

  runApp(
    MyApp(goRouter: appRouter.goRouter),
  );
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
