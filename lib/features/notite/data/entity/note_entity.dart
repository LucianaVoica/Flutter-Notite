class NoteEntity {
  NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
  });

  final String id;
  final String title;
  final String content;
  final String categoryId;
}
