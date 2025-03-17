import 'package:equatable/equatable.dart';
import '../../data/category_model.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  CategoryLoaded({required this.categories});
  final List<Category> categories;

  @override
  List<Object?> get props => <Object?>[categories];
}

class CategoryFailure extends CategoryState {
  CategoryFailure({required this.error});
  final String error;

  @override
  List<Object?> get props => <Object?>[error];
}
