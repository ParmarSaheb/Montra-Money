import 'package:equatable/equatable.dart';
import 'package:montra_clone/app/category_png_icons.dart';

class CategoryModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String imagePath;
  final bool isIncome;
  final bool isDeleted;

  CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.imagePath,
    required this.isIncome,
    this.isDeleted = false,
  });

  factory CategoryModel.empty() => CategoryModel(id: "", userId: "", name: "", imagePath: "", isIncome: false);

  @override
  List<Object> get props => [id, userId, name, imagePath, isIncome];

  static List<CategoryModel> get allCategories => CategoryPngIcons.values
      .map((e) => CategoryModel(
            id: "id",
            userId: "userId",
            name: e.name,
            imagePath: e.path,
            isIncome: e.index % 2 == 0,
          ))
      .toList();

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "name": name,
      "imagePath": imagePath,
      "isIncome": isIncome,
      "isDeleted": isDeleted,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'] ?? "-",
      imagePath: json['imagePath'] ?? "",
      isIncome: json['isIncome'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
    );
  }
}
