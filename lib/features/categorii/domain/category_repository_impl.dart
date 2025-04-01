import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/models/category_model.dart';
import 'icategory_repository.dart';

class CategoryRepositoryImpl implements ICategoryRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final PostgrestList response = await supabase.from('categories').select();
    return response.map((PostgrestMap e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    await supabase.from('categories').insert(category.toJson());
  }

  @override
  Future<void> selectCategory(String categoryId) async {
    try {
      ///default in supabase toate false initial;
      // selectul nu l-as tine in baza doar date
      await supabase
          .from('categories')
          .update(<dynamic, dynamic>{'isSelected': false})
          .neq('id', categoryId);
      await supabase
          .from('categories')
          .update(<dynamic, dynamic>{'isSelected': true})
          .eq('id', categoryId);
    } catch (error) {
      throw Exception('Eroare la selectarea categoriei: $error');
    }
  }
}
