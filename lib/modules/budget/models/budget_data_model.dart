import 'package:equatable/equatable.dart';
import 'package:montra_clone/modules/categories/models/category_model.dart';

class BudgetDataModel extends Equatable {
  const BudgetDataModel({
    required this.createdAt,
    required this.category,
    required this.budgetAmount,
    required this.budgetId,
    required this.alertLimit,
    required this.shouldReceiveAlert,
  });

  final int createdAt;
  final CategoryModel category;
  final double budgetAmount;
  final String budgetId;
  final double? alertLimit;
  final bool shouldReceiveAlert;

  @override
  List<Object?> get props => [
        createdAt,
        category,
        budgetAmount,
        budgetId,
        alertLimit,
        shouldReceiveAlert,
      ];
}
