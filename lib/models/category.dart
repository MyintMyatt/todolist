class Category {
  int? id;
  String categoryName;

  Category({this.id, required this.categoryName});

  Map<String, dynamic> toMap() {
    return {'categoryName': categoryName};
  }

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(id: map['id'], categoryName: map['categoryName']);
  }
}
