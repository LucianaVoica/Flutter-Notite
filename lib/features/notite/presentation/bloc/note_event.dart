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
