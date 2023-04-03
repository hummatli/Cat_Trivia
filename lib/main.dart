import 'package:cat_trivia/di/di_container.dart' as di;
import 'package:flutter/material.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setupDi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Trivia',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AppRouter(),
    );
  }
}
