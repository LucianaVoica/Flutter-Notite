import 'package:flutter/material.dart';

import '../../data/category_model.dart';

class Category extends StatelessWidget {
  const Category({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color:
            category.isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
      ),
      child: Center(
        child: Text(
          category.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: category.isSelected ? Colors.black : Colors.black87,
            fontWeight: category.isSelected ? FontWeight.bold : FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
