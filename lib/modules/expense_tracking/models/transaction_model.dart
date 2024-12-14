import 'package:equatable/equatable.dart';
import 'package:montra_clone/modules/categories/models/category_model.dart';

class TransactionModel extends Equatable {
  const TransactionModel({
    required this.transactionId,
    required this.transactionAmount,
    required this.description,
    required this.createdAt,
    required this.category,
    required this.isExpense,
  });

  final String transactionId;
  final String transactionAmount;
  final String description;
  final int createdAt;
  final CategoryModel? category;
  final bool isExpense;

  static Map<String, dynamic> toFireStore(TransactionModel transactionModel) {
    return {
      'transactionId': transactionModel.transactionId,
      'transactionAmount': transactionModel.transactionAmount,
      'description': transactionModel.description,
      'createdAt': transactionModel.createdAt,
      'category': transactionModel.category?.toJson(),
      'isExpense': transactionModel.isExpense
    };
  }

  factory TransactionModel.fromFireStore(Map<String, dynamic> data) {
    return TransactionModel(
      transactionId: data['transactionId'],
      transactionAmount: data['transactionAmount'],
      description: data['description'],
      createdAt: data['createdAt'],
      category: data['category'] == null ? null : CategoryModel.fromJson(data['category']),
      isExpense: data['isExpense'],
    );
  }

  @override
  List<Object?> get props => [
        transactionAmount,
        transactionId,
        description,
        createdAt,
        category,
        isExpense,
      ];
}
