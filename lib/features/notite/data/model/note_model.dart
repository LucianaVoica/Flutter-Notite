class NoteModel {
  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.categoryId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      categoryId: json['category_id'] as String,
    );
  }
  final String id;
  final String title;
  final String content;
  final String categoryId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'category_id': categoryId,
    };
  }
}
