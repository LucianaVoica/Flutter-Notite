import 'package:equatable/equatable.dart';
import '../../data/category_model.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class LoadCategories extends CategoryEvent {
  LoadCategories({required this.categories});
  final List<Category> categories;

  @override
  List<Object?> get props => <Object?>[categories];
}

class SelectCategory extends CategoryEvent {
  SelectCategory(this.categoryId);
  final String categoryId;
}

class AddCategory extends CategoryEvent {
  AddCategory({required this.category});
  final Category category;

  @override
  List<Object?> get props => <Object?>[category];
}
