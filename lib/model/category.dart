class Category{
  int id;
  String name;
  String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon
  });

  // Convert Category to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }

  // Convert Map to Category
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
    );
  }
}