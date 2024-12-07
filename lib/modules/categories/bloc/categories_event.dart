part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class UpdateStateCategoriesEvent extends CategoriesEvent {
  final CategoriesState state;
  const UpdateStateCategoriesEvent(this.state);

  @override
  List<Object> get props => [];
}

class LoadCategoriesEvent extends CategoriesEvent {
  const LoadCategoriesEvent();

  @override
  List<Object> get props => [];
}

class AddEditCategoriesEvent extends CategoriesEvent {
  final String? updatableCategoryId;
  final CategoryPngIcons icon;
  final String name;
  final bool isIncome;

  const AddEditCategoriesEvent({
    this.updatableCategoryId,
    required this.icon,
    required this.name,
    required this.isIncome,
  });

  @override
  List<Object> get props => [icon, name, isIncome];
}

class DeleteCategoryEvent extends CategoriesEvent {
  final String id;

  DeleteCategoryEvent({required this.id});

  @override
  List<Object> get props => [id];
}