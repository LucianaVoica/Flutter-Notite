import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<SelectCategory>(_onSelectCategory);
    on<AddCategory>(_onAddCategory);
  }

  void _onLoadCategories(LoadCategories event, Emitter<CategoryState> emit) {
    emit(CategoryLoaded(categories: event.categories));
  }

  void _onSelectCategory(SelectCategory event, Emitter<CategoryState> emit) {
    if (state is CategoryLoaded) {
      final List<Category> updatedCategories =
          (state as CategoryLoaded).categories.map((Category category) {
            return category.id == event.categoryId
                ? category.copyWith(isSelected: true)
                : category.copyWith(isSelected: false);
          }).toList();
      emit(CategoryLoaded(categories: updatedCategories));
    }
  }

  Future<void> _onAddCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is CategoryLoaded) {
      final List<Category> updatedCategories = List<Category>.from(
        (state as CategoryLoaded).categories,
      )..add(event.category);
      emit(CategoryLoaded(categories: updatedCategories));
    }
  }
}
