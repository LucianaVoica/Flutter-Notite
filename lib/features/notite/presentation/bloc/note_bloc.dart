import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/supabase_service.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteLoading()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
    on<PinNote>(_onPinNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    try {
      final notes = await SupabaseService.loadNotes(event.categoryId);
      emit(NoteLoaded(notes: notes));
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    try {
      await SupabaseService.addNote(event.note);
      final notes = await SupabaseService.loadNotes(event.note.categoryId);
      emit(NoteLoaded(notes: notes));
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    try {
      await SupabaseService.updateNote(event.note);
      final notes = await SupabaseService.loadNotes(event.note.categoryId);
      emit(NoteLoaded(notes: notes));
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    try {
      await SupabaseService.deleteNote(event.noteId);
      final notes = await SupabaseService.loadNotes(event.categoryId);
      emit(NoteLoaded(notes: notes));
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
  }

  Future<void> _onPinNote(PinNote event, Emitter<NoteState> emit) async {
    try {
      await SupabaseService.pinNote(event.noteId, event.isPinned);
      final notes = await SupabaseService.loadNotes(event.categoryId);
      emit(NoteLoaded(notes: notes));
    } catch (error) {
      emit(NoteFailure(error: error.toString()));
    }
  }
}
