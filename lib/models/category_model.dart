import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

class CategoryModel {
  List<Category> categories;

  CategoryModel({required this.categories});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categories: List<Category>.from(
      json["categories"].map((x) => Category.fromJson(x)),
    ),
  );
}

class Category {
  String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}
