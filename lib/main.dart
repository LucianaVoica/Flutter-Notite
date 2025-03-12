import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import 'pages/landing_page.dart';
import 'theme/theme.dart';
import 'widget/category/components/category_bloc.dart';
import 'widget/category/components/category_model.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider(
          create:
              (_) =>
                  CategoryBloc()..add(
                    LoadCategories(
                      categories: <Category>[
                        Category(id: '1', name: 'All', isSelected: true),
                        Category(id: '2', name: 'Pinned', isSelected: false),
                        Category(id: '3', name: 'Work', isSelected: false),
                        Category(id: '4', name: 'Personal', isSelected: false),
                      ],
                    ),
                  ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'My Notes';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notite',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const LandingPage(appTitle: appTitle),
    );
  }
}
