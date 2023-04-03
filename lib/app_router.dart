import 'package:flutter/material.dart';
import 'features/cat_fact/cat_fact_page.dart';
import 'features/fact_history/fact_history_page.dart';

class AppRouter extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  Future<bool> _onWillPop() async {
    if (_navigatorKey.currentState!.canPop()) {
      _navigatorKey.currentState!.pop();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) => CatFactPage(),
              );
            case '/fact-history':
              return MaterialPageRoute(
                builder: (context) => FactHistoryPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => CatFactPage(),
              );
          }
        },
      ),
    );
  }
}