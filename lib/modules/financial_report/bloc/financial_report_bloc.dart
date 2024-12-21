import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/utils/fire_store_queries.dart';
import 'package:montra_clone/modules/categories/models/category_model.dart';

part 'financial_report_event.dart';
part 'financial_report_state.dart';

class FinancialReportBloc extends Bloc<FinancialReportEvent, FinancialReportState> {
  FinancialReportBloc() : super(const FinancialReportState()) {
    on<PageChangeEvent>(_setIndex);
    on<FetchThisMonthFinancialReportEvent>(_fetchReportInformation);
  }

  void _setIndex(
    PageChangeEvent event,
    Emitter<FinancialReportState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.index));
  }

  Future<void> _fetchReportInformation(
    FetchThisMonthFinancialReportEvent event,
    Emitter<FinancialReportState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FinancialReportStateStatus.loading));
      final querySnapshotData = await FireStoreQueries.instance.getThisMonthExpenseIncomeData();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> incomeQueryList = [];
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> expenseQueryList = [];
      final List<double> incomeAmountList = [];
      final List<double> expenseAmountList = [];
      for (var e in querySnapshotData) {
        if (e.data()['isExpense'] == true) {
          expenseQueryList.add(e);
        } else {
          incomeQueryList.add(e);
        }
      }
      for (var e in incomeQueryList) {
        incomeAmountList.add(double.parse(e.data()['transactionAmount']));
      }
      incomeQueryList.sort((a, b) => double.parse(b.data()['transactionAmount']).compareTo(double.parse(a.data()['transactionAmount'])));
      for (var e in expenseQueryList) {
        expenseAmountList.add(double.parse(e.data()['transactionAmount']));
      }
      expenseQueryList.sort((a, b) => double.parse(b.data()['transactionAmount']).compareTo(double.parse(a.data()['transactionAmount'])));
      final highestIncome = incomeQueryList.first.data()['transactionAmount'];
      final highestExpense = expenseQueryList.first.data()['transactionAmount'];
      final CategoryModel incomeCategory = CategoryModel.fromJson(incomeQueryList.first.data()['category']);
      final CategoryModel expenseCategory = CategoryModel.fromJson(expenseQueryList.first.data()['category']);
      final double totalExpense = expenseAmountList.reduce(
        (previousValue, element) => previousValue + element,
      );
      final double totalIncome = incomeAmountList.reduce(
        (previousValue, element) => previousValue + element,
      );
      emit(state.copyWith(
        status: FinancialReportStateStatus.success,
        totalIncome: totalIncome.toString(),
        totalExpense: totalExpense.toString(),
        expenseCategory: expenseCategory,
        incomeCategory: incomeCategory,
        highestExpense: highestExpense,
        highestIncome: highestIncome,
      ));
    } catch (e) {
      emit(state.copyWith(status: FinancialReportStateStatus.failure));
    }
  }
}
