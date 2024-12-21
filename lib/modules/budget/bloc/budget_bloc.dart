import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:montra_clone/app/routes/router/router.dart';
import 'package:montra_clone/core/utils/devlog.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/core/validators/empty_field_validator.dart';
import 'package:montra_clone/modules/budget/models/budget_data_model.dart';
import 'package:montra_clone/modules/categories/bloc/categories_bloc.dart';
import 'package:montra_clone/modules/categories/models/category_model.dart';

part 'budget_event.dart';

part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(const BudgetState()) {
    on<AmountTextFieldChangeEvent>(_amountFieldChange);
    on<SetCategoryEvent>(_setCategory);
    on<ReceiveAlertSwitchChangeEvent>(_setSwitchValue);
    on<SliderChangeEvent>(_setSliderValue);
    on<LoadCategoryList>(_loadCategoryList);
    on<AddEditBudgetEvent>(_addEditBudget);
    on<LoadBudgetDataFromFireStoreEvent>(_loadData);
    on<DeleteBudgetEvent>(_deleteBudget);
    on<UpdateBudgetEvent>(_updateBudget);
  }

  void _setCategory(
    SetCategoryEvent event,
    Emitter<BudgetState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  void _setSwitchValue(
    ReceiveAlertSwitchChangeEvent event,
    Emitter<BudgetState> emit,
  ) {
    emit(state.copyWith(shouldReceiveAlert: event.shouldReceiveAlert));
  }

  void _setSliderValue(
    SliderChangeEvent event,
    Emitter<BudgetState> emit,
  ) {
    emit(state.copyWith(sliderValue: event.sliderValue));
  }

  void _amountFieldChange(
    AmountTextFieldChangeEvent event,
    Emitter<BudgetState> emit,
  ) {
    final amount = EmptyFieldValidator.dirty(event.amount);
    emit(
      state.copyWith(
        amount: amount,
        isValid: Formz.validate(
          [amount],
        ),
      ),
    );
  }

  Future<void> _addEditBudget(
    AddEditBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      final amount = EmptyFieldValidator.dirty(state.amount.value);
      emit(
        state.copyWith(
          amount: amount,
          isValid: Formz.validate(
            [amount],
          ),
        ),
      );
      if (state.isValid) {
        if (state.category != null) {
          final ref = await FireStoreQueries.instance.getBudgetCollectionReference();
          final id = event.updatableBudgetId ?? ref.doc().id;
          emit(state.copyWith(status: BudgetStateStatus.loading));
          final data = {
            "id": id,
            if (event.updatableBudgetId == null) 'createdAt': DateTime.now().millisecondsSinceEpoch,
            'updatedAt': DateTime.now().microsecondsSinceEpoch,
            'category': state.category?.toJson(),
            'budgetAmount': double.tryParse(state.amount.value) ?? 0,
            if (state.shouldReceiveAlert) 'alertLimit': state.sliderValue,
            'shouldReceiveAlert': state.shouldReceiveAlert,
          };
          if (event.updatableBudgetId == null)
            await ref.doc(id).set(data);
          else
            await ref.doc(id).update(data);

          emit(state.copyWith(status: BudgetStateStatus.success));
        } else {
          emit(state.copyWith(
            status: BudgetStateStatus.failure,
            errorMessage: 'Please select Category',
          ));
        }
      }
    } catch (e) {
      devlogError("error : $e");
      emit(state.copyWith(status: BudgetStateStatus.failure, errorMessage: 'Something went wrong,Please try again later'));
    }
  }

  Future<List<BudgetDataModel>> getBudgetData() async {
    final queryDocSnapshot =
        await FireStoreQueries.instance.getThisMonthBudgetData();
    final List<BudgetDataModel> budgetDataModelList = [];
    for (var element in queryDocSnapshot) {
      devlog("budgetDataModelList ${element.data()['category']}");
      budgetDataModelList.add(
        BudgetDataModel(
          createdAt: element.data()['createdAt'],
          category: CategoryModel.fromJson(element.data()['category']),
          budgetAmount: (element.data()['budgetAmount']).toDouble(),
          budgetId: element.id,
          alertLimit: (element.data()['shouldReceiveAlert'] == false) ? null : (element.data()['alertLimit']).toDouble(),
          shouldReceiveAlert: element.data()['shouldReceiveAlert'],
        ),
      );
    }
    devlog("budgetDataModelList : ${budgetDataModelList.map((e) => e.category.name)}");
    return budgetDataModelList;
  }

  Map<String, double> getCategoryMap(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocSnapshot, List<CategoryModel> categoryList) {
    // final categoryList = navKey.currentContext?.categoryByIncome(false) ?? [CategoryModel.empty()];
    devlog("categoryList : ${categoryList}");
    final Map<String, double> categoryMap = {};
    for (var category in categoryList) {
      final spentAmountList = [];
      for (var a in queryDocSnapshot) {
        if (a.data()['category']['id'] == category.id) {
          spentAmountList.add(double.parse(a.data()['transactionAmount']));
        }
      }
      final amount = spentAmountList.fold(
        0.0,
        (previousValue, element) => previousValue + element,
      );
      categoryMap[category.id] = amount;
    }
    return categoryMap;
  }

  Future<void> _loadData(
    LoadBudgetDataFromFireStoreEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BudgetStateStatus.loading));
      final budgetDataList = await getBudgetData();
      final queryDocSnapshot =
          await FireStoreQueries.instance.getThisMonthExpenseIncomeData();
      final categoryMap = getCategoryMap(queryDocSnapshot, event.expenseCates);
      emit(state.copyWith(
        status: BudgetStateStatus.success,
        spentAmountMap: categoryMap,
        budgetDataModelList: budgetDataList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BudgetStateStatus.failure,
        errorMessage: 'Something went wrong',
      ));
    }
  }

  Future<void> _loadCategoryList(
    LoadCategoryList event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      List<CategoryModel> categoryList = event.categories;
      final ref = await FireStoreQueries.instance.getBudgetCollectionReference();
      final snapshot = await ref.get();
      final dataList = snapshot.docs;
      if (dataList.isNotEmpty) {
        for (var e in dataList) {
          if (categoryList.contains(e.data()['category']['id'])) {
            categoryList.remove(e.data()['category']);
          }
        }
      }
      emit(state.copyWith(categoryList: categoryList));
    } catch (e) {
      emit(state.copyWith(
          status: BudgetStateStatus.failure,
          errorMessage: 'Could not load list data'));
    }
  }

  Future<void> _deleteBudget(
    DeleteBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      final ref =
          await FireStoreQueries.instance.getBudgetCollectionReference();
      await ref.doc(event.budgetID).delete();
      emit(state.copyWith(status: BudgetStateStatus.deletedSuccessfully));
    } catch (e) {
      emit(state.copyWith(
          status: BudgetStateStatus.failure,
          errorMessage: 'Could not delete budget! Please try again.'));
    }
  }

  Future<void> _updateBudget(
    UpdateBudgetEvent event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      final amount = EmptyFieldValidator.dirty(state.amount.value == ''
          ? event.budgetAmount.toString()
          : state.amount.value);
      emit(
        state.copyWith(
          status: BudgetStateStatus.loading,
          amount: amount,
          isValid: Formz.validate(
            [amount],
          ),
        ),
      );
      if (state.isValid) {
        final ref =
            await FireStoreQueries.instance.getBudgetCollectionReference();
        await ref.doc(event.budgetID).update({
          'budgetAmount': double.parse(state.amount.value),
          'shouldReceiveAlert': state.shouldReceiveAlert,
          'alertLimit':
              !state.shouldReceiveAlert ? null : state.sliderValue ?? 80,
        });
        emit(state.copyWith(status: BudgetStateStatus.updatedSuccessfully));
      } else {
        emit(state.copyWith(
          status: BudgetStateStatus.failure,
          errorMessage: 'Something went wrong.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: BudgetStateStatus.failure,
        errorMessage: 'Could not update budget! Please try again.',
      ));
    }
  }
}
