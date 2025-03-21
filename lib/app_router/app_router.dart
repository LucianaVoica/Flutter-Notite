import 'package:flutter/material.dart';

import '../features/notite/presentation/pages/lista_notite.dart';
import '../pages/landin_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LandingPage.route:
        return MaterialPageRoute<dynamic>(builder: (_) => const LandingPage());
      case ListaNotite.route:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ListaNotite(categoryType: ''),
        );
      default:
        return MaterialPageRoute<dynamic>(builder: (_) => const LandingPage());
    }
  }
}
