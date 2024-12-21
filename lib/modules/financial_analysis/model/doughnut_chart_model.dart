import 'package:flutter/material.dart';
import 'package:montra_clone/modules/categories/models/category_model.dart';

class DoughnutChartData {
  const DoughnutChartData({
    required this.category,
    required this.color,
    required this.value,
  });

  final CategoryModel category;
  final Color color;
  final double value;
}
