import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/categories/data/models/category_model.dart';
import '../../features/notite/data/model/note_model.dart';

class SupabaseService {
  static late final SupabaseClient supabaseClient;

  static Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANONKEY']!,
    );
    supabaseClient = Supabase.instance.client;

    await _ensureDefaultCategories();
  }

  static Future<void> _ensureDefaultCategories() async {
    final List<Map<String, dynamic>> existingCategories =
        await supabaseClient.from('categories').select();

    if (existingCategories.isEmpty) {
      await supabaseClient.from('categories').insert(<Map<String, Object>>[
        <String, Object>{
          'id': '00000000-0000-0000-0000-000000000001',
          'name': 'All',
          'is_default': true,
        },
        <String, Object>{
          'id': '00000000-0000-0000-0000-000000000002',
          'name': 'Work',
          'is_default': true,
        },
        <String, Object>{
          'id': '00000000-0000-0000-0000-000000000003',
          'name': 'Personal',
          'is_default': true,
        },
      ]);
    }
  }

  //Categorii

  static Future<List<CategoryModel>> loadCategories() async {
    final PostgrestList data = await supabaseClient.from('categories').select();

    return data.map<CategoryModel>((PostgrestMap category) {
      return CategoryModel(
        id: category['id'].toString(),
        name: category['name'].toString(),
        isSelected: false,
      );
    }).toList();
  }

  static Future<void> addCategory(CategoryModel category) async {
    await supabaseClient.from('categories').insert(<String, Object>{
      'name': category.name,
      'is_default': false,
    });
  }

  static Future<void> deleteCategory(String categoryId) async {
    await supabaseClient.from('categories').delete().eq('id', categoryId);
  }

  //Note

  static Future<List<NoteModel>> loadNotes(String categoryId) async {
    final List<Map<String, dynamic>> notesData = await supabaseClient
        .from('notes')
        .select()
        .eq('category_id', categoryId);

    return notesData.map((Map<String, dynamic> note) {
      return NoteModel(
        id: note['id'].toString(),
        title: note['title'].toString(),
        content: note['content'].toString(),
        categoryId: note['category_id'].toString(),
        isPinned: note['isPinned'] as bool,
      );
    }).toList();
  }

  static Future<void> addNote(NoteModel note) async {
    await supabaseClient.from('notes').insert(<String, dynamic>{
      'title': note.title,
      'content': note.content,
      'category_id': note.categoryId,
      'isPinned': note.isPinned,
    });
  }

  static Future<void> updateNote(NoteModel note) async {
    await supabaseClient
        .from('notes')
        .update(<dynamic, dynamic>{
          'title': note.title,
          'content': note.content,
          'category_id': note.categoryId,
          'isPinned': note.isPinned,
        })
        .eq('id', note.id);
  }

  static Future<void> deleteNote(String noteId) async {
    await supabaseClient.from('notes').delete().eq('id', noteId);
  }

  static Future<void> pinNote(String noteId, bool isPinned) async {
    await supabaseClient
        .from('notes')
        .update(<dynamic, dynamic>{'isPinned': isPinned})
        .eq('id', noteId);
  }
}
