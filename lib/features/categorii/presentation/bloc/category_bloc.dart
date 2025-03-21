import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/supabase_service.dart';
import '../../data/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<SelectCategory>(_onSelectCategory);
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
    emit(CategorySelected(categoryId: event.categoryId)); // Navigare
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

  @override
  Future<void> onTransition(
    Transition<CategoryEvent, CategoryState> transition,
  ) async {
    super.onTransition(transition);
    if (transition.nextState is CategoryFailure) {
      add(LoadCategories(categories: const <CategoryModel>[]));
    }
  }

  Future<void> _onAddCategory(
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
}
