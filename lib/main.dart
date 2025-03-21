import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nested/nested.dart';

import 'app_router/app_router.dart';
import 'features/categorii/data/category_model.dart';
import 'features/categorii/presentation/bloc/category_bloc.dart';
import 'features/categorii/presentation/bloc/category_event.dart';
import 'features/notite/presentation/bloc/note_bloc.dart';
import 'pages/landin_page.dart';
import 'services/locator.dart';
import 'services/supabase_service.dart';
import 'theme/gradient.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await SupabaseService.init();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider(
          create:
              (_) =>
                  CategoryBloc()
                    ..add(LoadCategories(categories: const <CategoryModel>[])),
        ),
        BlocProvider(create: (_) => NoteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notite',
        initialRoute: LandingPage.route, // ruta initiala
        onGenerateRoute: AppRouter.generateRoute, //foloseste approute pt rute
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const GradientBackground(child: LandingPage()),
      ),
    );
  }
}
