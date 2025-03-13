part of 'category_bloc.dart';

abstract class CategoryEvent {}

class LoadCategories extends CategoryEvent {
  LoadCategories({required this.categories});
  final List<Category> categories;
}

class SelectCategory extends CategoryEvent {
  SelectCategory({required this.categoryId});
  final String categoryId;
}

class AddCategory extends CategoryEvent {
  AddCategory({required this.category});
  final Category category;
}
