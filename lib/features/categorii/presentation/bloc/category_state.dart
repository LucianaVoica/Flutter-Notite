import 'package:equatable/equatable.dart';
import '../../data/category_model.dart';

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
