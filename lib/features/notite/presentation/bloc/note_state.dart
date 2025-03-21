import 'package:equatable/equatable.dart';
import '../../data/model/note_model.dart';

abstract class NoteState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  NoteLoaded({required this.notes});
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
