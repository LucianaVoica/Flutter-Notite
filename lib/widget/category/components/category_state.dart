part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  CategoryLoaded({required this.categories});
  final List<Category> categories;
}
