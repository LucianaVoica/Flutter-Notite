import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nested/nested.dart';

import 'core/services/locator.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/theme.dart';
import 'features/categories/data/models/category_model.dart';
import 'features/categories/presentation/bloc/category_bloc.dart';
import 'features/categories/presentation/bloc/category_event.dart';
import 'features/landing/presentation/landing_page.dart';
import 'features/notite/presentation/bloc/note_bloc.dart';
import 'features/notite/presentation/bloc/note_event.dart';

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
        BlocProvider(
          create:
              (BuildContext context) =>
                  NoteBloc()..add(
                    LoadNotes(
                      categoryId: '00000000-0000-0000-0000-000000000001',
                    ),
                  ),
        ),
        BlocProvider<NoteBloc>(create: (BuildContext context) => NoteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notite',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const LandingPage(),
      ),
    );
  }
}
