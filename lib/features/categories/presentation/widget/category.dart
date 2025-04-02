import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    //! Chp - nu container
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      child: Center(
        child: Text(
          category.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
