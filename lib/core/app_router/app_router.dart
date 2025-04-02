import 'package:flutter/material.dart';
import '../../features/landing/presentation/landin_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LandingPage.route:
        return MaterialPageRoute<dynamic>(builder: (_) => const LandingPage());
      default:
        return MaterialPageRoute<dynamic>(builder: (_) => const LandingPage());
    }
  }
}
