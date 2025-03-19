import 'package:flutter/material.dart';

import '../pages/landin_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LandingPage.route:
        return MaterialPageRoute(builder: (_) => const LandingPage());

      default:
        return MaterialPageRoute(builder: (_) => const LandingPage());
    }
  }
}
