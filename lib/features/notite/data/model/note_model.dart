// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../entity/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel({
    required super.id,
    required super.title,
    required super.content,
    required super.categoryId,
    required super.isPinned,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'category_id': categoryId,
      'isPinned': isPinned,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      categoryId: json['category_id'] as String,
      isPinned: json['isPinned'] as bool,
    );
  }
}
