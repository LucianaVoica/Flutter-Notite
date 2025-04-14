import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/supabase_service.dart';
import '../../data/models/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onInsertCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final List<CategoryModel> categories =
          await SupabaseService.loadCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (error) {
      emit(CategoryFailure(error: error.toString()));
    }
  }

  Future<void> _onInsertCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await SupabaseService.addCategory(event.category);
      final List<CategoryModel> categories =
          await SupabaseService.loadCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (error) {
      emit(CategoryFailure(error: error.toString()));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await SupabaseService.deleteCategory(event.category.id);
      final List<CategoryModel> categories =
          await SupabaseService.loadCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (error) {
      emit(CategoryFailure(error: error.toString()));
    }
  }
}
