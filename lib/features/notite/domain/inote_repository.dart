import '../data/model/note_model.dart';

abstract class INoteRepository {
  Future<List<NoteModel>> getNotesByCategory(String categoryId);
  Future<void> addNote(NoteModel note);
}
