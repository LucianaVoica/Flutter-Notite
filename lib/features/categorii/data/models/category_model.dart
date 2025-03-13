class Category {
  Category({required this.id, required this.name, required this.isSelected});

  final String id;
  final String name;
  final bool isSelected;

  Category copyWith({String? id, String? name, bool? isSelected}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
