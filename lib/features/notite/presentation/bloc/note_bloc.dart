import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/supabase_service.dart';
import '../../data/model/note_model.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteLoading()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    try {
      final List<Map<String, dynamic>> notesData = await SupabaseService
          .supabaseClient
          .from('notes')
          .select()
          .eq('category_id', event.categoryId);

      final List<NoteModel> notes =
          notesData.map((Map<String, dynamic> note) {
            return NoteModel(
              id: note['id'].toString(),
              title: note['title'].toString(),
              content: note['content'].toString(),
              categoryId: note['category_id'].toString(),
            );
          }).toList();

      emit(NoteLoaded(notes: notes));
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    try {
      final Map<String, dynamic> newNote = <String, dynamic>{
        'title': event.note.title,
        'content': event.note.content,
        'category_id': event.note.categoryId,
      };

      await SupabaseService.supabaseClient.from('notes').insert(newNote);
      print('📌 Bloc a primit evenimentul AddNote: ${event.note.title}');

      final List<NoteModel> updatedNotes = List<NoteModel>.from(
        (state is NoteLoaded) ? (state as NoteLoaded).notes : <dynamic>[],
      )..add(event.note);

      emit(NoteLoaded(notes: updatedNotes));
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
    print('✅ Notița a fost adăugată cu succes!');
  }
}
