import 'package:equatable/equatable.dart';

import '../../data/model/note_model.dart';

abstract class NoteEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class LoadNotes extends NoteEvent {
  LoadNotes({required this.categoryId});
  final String categoryId;

  @override
  List<Object?> get props => <Object?>[categoryId];
}

class AddNote extends NoteEvent {
  AddNote({required this.note});
  final NoteModel note;

  @override
  List<Object?> get props => <Object?>[note];
}

class UpdateNote extends NoteEvent {
  UpdateNote({required this.note});
  final NoteModel note;

  @override
  List<Object?> get props => <Object?>[note];
}

class DeleteNote extends NoteEvent {
  DeleteNote({required this.noteId, required this.categoryId});

  final String noteId;
  final String categoryId;
}

class PinNote extends NoteEvent {
  PinNote({
    required this.categoryId,
    required this.noteId,
    required this.isPinned,
  });

  final String noteId;
  final String categoryId;
  final bool isPinned;

  @override
  List<Object?> get props => <Object?>[categoryId, noteId, isPinned];
}

class LoadPinnedNotes extends NoteEvent {}
