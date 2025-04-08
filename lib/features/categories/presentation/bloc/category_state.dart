import 'package:equatable/equatable.dart';
import '../../data/models/category_model.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];

  void get categories {}
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  CategoryLoaded({required this.categories});
  @override
  final List<CategoryModel> categories;

  @override
  List<Object?> get props => <Object?>[categories];
}

class CategoryFailure extends CategoryState {
  CategoryFailure({required this.error});
  final String error;

  @override
  List<Object?> get props => <Object?>[error];
}

class CategorySelected extends CategoryState {
  CategorySelected({required this.categoryId});

  final String categoryId;

  @override
  List<Object?> get props => <Object?>[categoryId];
}

class CategoryAddSuccess extends CategoryState {
  CategoryAddSuccess({required this.category});
  final CategoryModel category;

  @override
  List<Object?> get props => <Object?>[category];
}

class CategoryDeleteSuccess extends CategoryState {
  CategoryDeleteSuccess({required this.deletedCategoryId});
  final String deletedCategoryId;

  @override
  List<Object?> get props => <Object?>[deletedCategoryId];
}
