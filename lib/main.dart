import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'features/categorii/data/category_model.dart';
import 'features/categorii/presentation/bloc/category_bloc.dart';
import 'features/categorii/presentation/bloc/category_event.dart';
import 'pages/home.dart';
import 'theme/gradient.dart';
import 'theme/theme.dart';

void main() {
  final List<CategoryModel> initialCategories = <CategoryModel>[
    CategoryModel(id: '1', name: 'All', isSelected: true),
    CategoryModel(id: '2', name: 'Pinned', isSelected: false),
    CategoryModel(id: '3', name: 'Work', isSelected: false),
    CategoryModel(id: '4', name: 'Personal', isSelected: false),
  ];

  runApp(MyApp(categories: initialCategories));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider(
          create:
              (_) =>
                  CategoryBloc()..add(LoadCategories(categories: categories)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notite',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const GradientBackground(child: HomePage(appTitle: 'My Notes')),
      ),
    );
  }
}
