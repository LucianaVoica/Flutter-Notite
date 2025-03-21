class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.isSelected,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isSelected: false,
    );
  }

  final String id;
  final String name;
  final bool isSelected;

  CategoryModel copyWith({String? id, String? name, bool? isSelected}) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name};
  }
}
