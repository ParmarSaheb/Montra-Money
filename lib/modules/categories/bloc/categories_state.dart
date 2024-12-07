part of 'categories_bloc.dart';

enum CategoriesStateStatus {
  initial,
  loading,
  success,
  failure,
}

class CategoriesState extends Equatable {
  final CategoriesStateStatus status;
  final String errorMessage;
  final List<CategoryModel> categories;

  List<CategoryModel> get incomeCategories => categories.where((e) => e.isIncome).toList();

  List<CategoryModel> get expenseCategories => categories.where((e) => !e.isIncome).toList();

  const CategoriesState({
    this.status = CategoriesStateStatus.initial,
    this.errorMessage = '',
    this.categories = const [],
  });

  @override
  List<Object> get props => [status, errorMessage, categories];

  CategoriesState copyWith({
    CategoriesStateStatus? status,
    String? errorMessage,
    List<CategoryModel>? categories,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
    );
  }
}
