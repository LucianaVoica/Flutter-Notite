import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: implementation_imports
import 'package:postgrest/src/types.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../notite/presentation/bloc/note_bloc.dart';
import '../../../notite/presentation/bloc/note_event.dart';
import '../../data/models/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
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
      final PostgrestList data =
          await SupabaseService.supabaseClient.from('categories').select();

      final List<CategoryModel> categories =
          data.map<CategoryModel>((PostgrestMap category) {
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
      final Map<String, dynamic> response =
          await SupabaseService.supabaseClient
              .from('categories')
              .insert(<String, Object>{
                'name': event.category.name,
                'is_default': false,
              })
              .select()
              .single();

      final CategoryModel newCategory = CategoryModel(
        id: response['id'].toString(),
        name: response['name'].toString(),
        isSelected: false,
      );

      final List<CategoryModel> updatedCategories = List<CategoryModel>.from(
        (state as CategoryLoaded).categories,
      )..add(newCategory);

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
            error: 'Nu poți șterge această categorie, este una de bază.',
          ),
        );
        return;
      }

      final PostgrestList noteResponse =
          await SupabaseService.supabaseClient
              .from('notes')
              .delete()
              .eq('category_id', event.category.id)
              .select();

      if (noteResponse.error != null) {
        emit(
          CategoryFailure(
            error:
                // ignore: avoid_dynamic_calls
                'Eroare la ștergerea notițelor: ${noteResponse.error!.message}',
          ),
        );
        return;
      }

      final PostgrestList categoryResponse =
          await SupabaseService.supabaseClient
              .from('categories')
              .delete()
              .eq('id', event.category.id)
              .select();

      if (categoryResponse.error != null) {
        emit(
          CategoryFailure(
            error:
                // ignore: avoid_dynamic_calls
                'Eroare la ștergerea categoriei: ${categoryResponse.error!.message}',
          ),
        );
        return;
      }

      final List<CategoryModel> updatedCategories =
          currentCategories
              .where((CategoryModel c) => c.id != event.category.id)
              .toList();

      emit(CategoryLoaded(categories: updatedCategories));
    } catch (e) {
      emit(CategoryFailure(error: e.toString()));
    }
  }
}

extension on PostgrestList {
  get error => null;
}
