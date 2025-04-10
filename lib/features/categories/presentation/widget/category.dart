import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.onDelete,
  });

  final CategoryModel category;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(category.name),
      onPressed: onTap,
      onDeleted: onDelete,
      deleteIcon: const Icon(Icons.close, size: 18, color: Colors.red),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      side: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
      backgroundColor: Colors.white,
    );
  }
}
