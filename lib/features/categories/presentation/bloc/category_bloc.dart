import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/supabase_service.dart';
import '../../../notite/presentation/bloc/note_bloc.dart';
import '../../../notite/presentation/bloc/note_event.dart';
import '../../data/models/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<SelectCategory>(_onSelectCategory);
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

  Future<void> _onAddCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is! CategoryLoaded) {
      return;
    }

    try {
      await SupabaseService.addCategory(event.category);

      final List<CategoryModel> updatedCategories =
          await SupabaseService.loadCategories();

      emit(CategoryLoaded(categories: updatedCategories));
    } catch (error) {
      emit(CategoryFailure(error: error.toString()));
    }
  }

  void _onSelectCategory(SelectCategory event, Emitter<CategoryState> emit) {
    if (state is! CategoryLoaded) {
      return;
    }

    final List<CategoryModel> updatedCategories =
        (state as CategoryLoaded).categories.map((CategoryModel category) {
          return category.id == event.categoryId
              ? category.copyWith(isSelected: true)
              : category.copyWith(isSelected: false);
        }).toList();

    emit(CategoryLoaded(categories: updatedCategories));
    emit(CategorySelected(categoryId: event.categoryId));

    final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(event.context);
    noteBloc.add(LoadNotes(categoryId: event.categoryId));
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is! CategoryLoaded) {
      return;
    }

    final List<CategoryModel> currentCategories =
        (state as CategoryLoaded).categories;

    final int index = currentCategories.indexWhere(
      (CategoryModel c) => c.id == event.category.id,
    );

    if (index < 3) {
      emit(
        CategoryFailure(
          error: 'Nu poți șterge această categorie, este una de bază.',
        ),
      );
      return;
    }

    try {
      await SupabaseService.deleteCategory(event.category.id);

      final List<CategoryModel> updatedCategories =
          await SupabaseService.loadCategories();

      emit(CategoryLoaded(categories: updatedCategories));
    } catch (error) {
      emit(CategoryFailure(error: error.toString()));
    }
  }
}
