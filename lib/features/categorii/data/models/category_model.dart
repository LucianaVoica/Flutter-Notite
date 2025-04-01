// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.isSelected,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name, 'isSelected': isSelected};
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }

  CategoryModel copyWith({String? id, String? name, bool? isSelected}) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
