import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/supabase_service.dart';
import '../../../notite/presentation/bloc/note_bloc.dart';
import '../../../notite/presentation/bloc/note_event.dart';
import '../../data/models/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
    on<CategoryEvent>((CategoryEvent event, Emitter<CategoryState> emit) {
      emit(CategoryLoading());
    });
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onInsertCategory);
    on<SelectCategory>(_onSelectCategory);
    on<DeleteCategory>(_onDeleteCategory);
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

    debugPrint('Categorie selectată: ${event.categoryId}');

    emit(CategoryLoaded(categories: updatedCategories));

    emit(CategorySelected(categoryId: event.categoryId));

    final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(event.context);
    noteBloc.add(LoadNotes(categoryId: event.categoryId));
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final List<Map<String, dynamic>> categoriesData =
          await SupabaseService.supabaseClient.from('categories').select();

      final List<CategoryModel> categories =
          categoriesData.map((Map<String, dynamic> category) {
            return CategoryModel(
              id: category['id'].toString(),
              name: category['name'].toString(),
              isSelected: false,
            );
          }).toList();

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
      await SupabaseService.supabaseClient.from('categories').insert(
        <String, Object>{'name': event.category.name, 'is_default': false},
      );

      final List<CategoryModel> updatedCategories = List<CategoryModel>.from(
        (state as CategoryLoaded).categories,
      )..add(event.category);

      emit(CategoryLoaded(categories: updatedCategories));
    } catch (error) {
      emit(CategoryFailure(error: error.toString()));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final List<CategoryModel> currentCategories =
          (state as CategoryLoaded).categories;

      final int index = currentCategories.indexWhere(
        (CategoryModel c) => c.id == event.category.id,
      );

      if (index < 3) {
        emit(
          CategoryFailure(
            error:
                'Nu poți șterge această categorie, este o categorie de bază.',
          ),
        );
        return;
      }

      await SupabaseService.supabaseClient
          .from('notes')
          .delete()
          .eq('category_id', event.category.id);

      await SupabaseService.supabaseClient
          .from('categories')
          .delete()
          .eq('id', event.category.id);

      final List<Map<String, dynamic>> categoriesData =
          await SupabaseService.supabaseClient.from('categories').select();

      final List<CategoryModel> updatedCategories =
          categoriesData.map((Map<String, dynamic> category) {
            return CategoryModel(
              id: category['id'].toString(),
              name: category['name'].toString(),
              isSelected: false,
            );
          }).toList();

      emit(CategoryLoaded(categories: updatedCategories));
    } catch (error) {
      emit(CategoryFailure(error: error.toString()));
    }
  }
}
