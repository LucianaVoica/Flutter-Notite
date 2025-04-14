class NoteEntity {
  NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    required this.isPinned,
  });

  final String id;
  final String title;
  final String content;
  final String categoryId;
  final bool isPinned;
}
