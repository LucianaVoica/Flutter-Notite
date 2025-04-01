import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/supabase_service.dart';
import '../../data/model/note_model.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteLoading()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
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

      final List<NoteModel> updatedNotes = List<NoteModel>.from(
        (state is NoteLoaded) ? (state as NoteLoaded).notes : <dynamic>[],
      )..add(event.note);

      emit(NoteLoaded(notes: updatedNotes));
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    try {
      final Map<String, String> updatedNote = <String, String>{
        'title': event.note.title,
        'content': event.note.content,
        'category_id': event.note.categoryId,
      };

      await SupabaseService.supabaseClient
          .from('notes')
          .update(updatedNote)
          .eq('id', event.note.id);

      if (state is NoteLoaded) {
        final List<NoteModel> updatedNotes =
            (state as NoteLoaded).notes.map((NoteModel note) {
              return note.id == event.note.id ? event.note : note;
            }).toList();

        emit(NoteLoaded(notes: updatedNotes));
      }
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    try {
      await SupabaseService.supabaseClient
          .from('notes')
          .delete()
          .eq('id', event.noteId);

      if (state is NoteLoaded) {
        final List<NoteModel> updatedNotes =
            (state as NoteLoaded).notes
                .where((NoteModel note) => note.id != event.noteId)
                .toList();

        emit(NoteLoaded(notes: updatedNotes));
      }
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
  }
}
