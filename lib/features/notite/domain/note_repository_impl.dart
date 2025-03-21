import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/model/note_model.dart';
import 'inote_repository.dart';

class NoteRepositoryImpl implements INoteRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Future<List<NoteModel>> getNotesByCategory(String categoryId) async {
    final PostgrestList response = await supabase
        .from('notes')
        .select()
        .eq('category_id', categoryId);

    return response.map((PostgrestMap e) => NoteModel.fromJson(e)).toList();
  }

  @override
  Future<void> addNote(NoteModel note) async {
    await supabase.from('notes').insert(note.toJson());
  }
}
