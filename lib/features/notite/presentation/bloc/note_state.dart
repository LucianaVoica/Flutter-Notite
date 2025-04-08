import 'package:equatable/equatable.dart';
import '../../data/model/note_model.dart';

abstract class NoteState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
  void get notes {}
}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  NoteLoaded({required this.notes});
  @override
  final List<NoteModel> notes;

  @override
  List<Object?> get props => <Object?>[notes];
}

class NoteFailure extends NoteState {
  NoteFailure({required this.error});
  final String error;

  @override
  List<Object?> get props => <Object?>[error];
}

class NoteAddSuccess extends NoteState {
  NoteAddSuccess({required this.note});
  final NoteModel note;

  @override
  List<Object?> get props => <Object?>[note];
}

class NoteUpdateSuccess extends NoteState {
  NoteUpdateSuccess({required this.note});
  final NoteModel note;

  @override
  List<Object?> get props => <Object?>[note];
}

class NoteDeleteSuccess extends NoteState {
  NoteDeleteSuccess({required this.deletedNoteId});
  final int deletedNoteId;

  @override
  List<Object?> get props => <Object?>[deletedNoteId];
}
