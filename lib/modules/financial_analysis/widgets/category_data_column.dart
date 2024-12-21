import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/core/utils/gap.dart';
import 'package:montra_clone/core/utils/size_config.dart';
import 'package:montra_clone/core/widgets/category_chip.dart';
import 'package:montra_clone/modules/expense_tracking/models/transaction_model.dart';

class CategoryDataColumn extends StatelessWidget {
  const CategoryDataColumn({
    super.key,
    required this.transacList,
    required this.isExpense,
    required this.categoryValueMap,
    required this.totalAmount,
    required this.onRefresh,
  });

  final List<TransactionModel> transacList;
  final bool isExpense;
  final Map<String, double> categoryValueMap;
  final double totalAmount;
  final Future<void> Function() onRefresh;

  double getAmount(String categoryName) {
    return double.parse(
      ((categoryValueMap[categoryName] ?? 0) * totalAmount).toStringAsFixed(2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = transacList.where((element) => element.isExpense == isExpense).toList();
    return Expanded(
      child: RefreshIndicator(
         onRefresh: onRefresh,
        child: ListView(
          // shrinkWrap: true,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              list.length,
              (index) {
                final tr = list[index];
                return CategoryProgressBar(
                  progressValue: categoryValueMap[tr.category?.id] ?? 0,
                  color: [AppColors.instance.primary, AppColors.instance.yellow100, AppColors.instance.blue100, AppColors.instance.red100][index % 4],
                  label: tr.category?.name ?? "-",
                  isExpense: isExpense,
                  amount: getAmount(tr.category?.id ?? ""),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryProgressBar extends StatelessWidget {
  const CategoryProgressBar({
    super.key,
    required this.progressValue,
    required this.label,
    required this.color,
    required this.isExpense,
    required this.amount,
  });

  final double progressValue;
  final Color color;
  final String label;
  final bool isExpense;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryChip(
              color: color,
              label: label,
            ),
            Text(
              isExpense ? '-\u{20B9}$amount' : '\u{20B9}$amount',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: isExpense
                    ? AppColors.instance.red100
                    : AppColors.instance.green100,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: LinearProgressIndicator(
            value: progressValue,
            color: color,
            backgroundColor: AppColors.instance.light20,
            minHeight: 10,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        VGap(1.h),
      ],
    );
  }
}
