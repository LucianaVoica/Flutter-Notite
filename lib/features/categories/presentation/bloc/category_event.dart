import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class LoadCategories extends CategoryEvent {
  LoadCategories({required this.categories});
  final List<CategoryModel> categories;

  @override
  List<Object?> get props => <Object?>[categories];
}

class SelectCategory extends CategoryEvent {
  SelectCategory({required this.categoryId, required this.context});

  final String categoryId;
  final BuildContext context;

  @override
  List<Object?> get props => <Object?>[categoryId, context];
}

class AddCategory extends CategoryEvent {
  AddCategory({required this.category});
  final CategoryModel category;

  @override
  List<Object?> get props => <Object?>[category];
}
