import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/category_png_icons.dart';
import 'package:montra_clone/core/utils/callbacks.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';

import '../../../core/utils/fire_store_queries.dart';
import '../models/category_model.dart';

part 'categories_event.dart';

part 'categories_state.dart';

extension CategoryList on BuildContext {
  List<CategoryModel> categoryByIncome(bool isIncome) => this.read<CategoriesBloc>().state.categories.where((e) => e.isIncome == isIncome).toList();
}

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState()) {
    on<UpdateStateCategoriesEvent>(_updateStateCategoriesEvent);
    on<LoadCategoriesEvent>(_loadCategories);
    on<AddEditCategoriesEvent>(_addEditCategory);
    on<DeleteCategoryEvent>(_deleteCategory);
  }

  void _updateStateCategoriesEvent(UpdateStateCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(event.state);
  }

  void _loadCategories(LoadCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(status: CategoriesStateStatus.loading));
    final String? userId = FireStoreQueries.instance.currentUserId;
    if (userId == null) {
      showToast(message: "User not found error.!");
      return;
    }
    final cates = await getCategories;
    emit(state.copyWith(
      status: CategoriesStateStatus.success,
      categories: cates,
    ));
  }

  void _addEditCategory(AddEditCategoriesEvent event, Emitter<CategoriesState> emit) async {
    final isSuccess = await apiCallback(
      name: "AddEditCategoriesEvent",
      doWhenOnline: () async {
        final String? userId = FireStoreQueries.instance.currentUserId;
        if (userId == null) {
          showToast(message: "User not found error.!");
          return false;
        }
        final ref = await FireStoreQueries.instance.getCategoryCollectionReference();
        final id = event.updatableCategoryId ?? ref.doc().id;

        final category = CategoryModel(
          id: id,
          userId: userId,
          name: event.name,
          imagePath: event.icon.path,
          isIncome: event.isIncome,
        );

        await ref.doc(id).set(category.toJson());

        return true;
      },
    );
    if (isSuccess) {
      final cates = await getCategories;
      emit(state.copyWith(categories: cates));
    } else {
      emit(state.copyWith(status: CategoriesStateStatus.failure, errorMessage: "Cannot ${event.updatableCategoryId != null ? "edit" : "add"} category.!"));
    }
  }

  void _deleteCategory(DeleteCategoryEvent event, Emitter<CategoriesState> emit) async {
    final s = await apiCallback(
      name: "DeleteCategoryEvent",
      doWhenOnline: () async {
        final ref = await FireStoreQueries.instance.getCategoryCollectionReference();
        await ref.doc(event.id).update({'isDeleted': true});
        return true;
      },
    );
    if (s) {
      final cates = await getCategories;
      emit(state.copyWith(categories: cates));
    } else {
      emit(state.copyWith(status: CategoriesStateStatus.failure, errorMessage: "Cannot delete category.!"));
    }
  }

  Future<List<CategoryModel>> get getCategories async {
    List<CategoryModel> cates = [];
    await apiCallback(
      name: "getCategories",
      doWhenOnline: () async {
        final ref = await FireStoreQueries.instance.getCategoryCollectionReference();
        final categorySnaps = await ref.get();
        final jsonDataList = categorySnaps.docs.map((e) => e.data()).toList();
        cates = jsonDataList.map((e) => CategoryModel.fromJson(e)).where((e) => !e.isDeleted).toList();
        return true;
      },
    );
    return cates;
  }
}
