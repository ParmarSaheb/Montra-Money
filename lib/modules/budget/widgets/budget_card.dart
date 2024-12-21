import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/core/extensions/to_indian_rupee_extension.dart';
import 'package:montra_clone/core/widgets/category_chip.dart';
import 'package:montra_clone/modules/budget/widgets/linear_progress_bar_widget.dart';
import 'package:montra_clone/modules/categories/models/category_model.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({
    super.key,
    required this.category,
    required this.spentAmount,
    required this.budgetAmount,
    required this.onCardTap,
    required this.alertLimit,
  });

  final CategoryModel category;
  final double spentAmount;
  final double budgetAmount;
  final VoidCallback onCardTap;
  final double? alertLimit;

  @override
  Widget build(BuildContext context) {
    final remaining =
        (budgetAmount - spentAmount) <= 0 ? 0 : budgetAmount - spentAmount;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      height: (spentAmount > budgetAmount) ? 180 : 170,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.instance.light100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryChip(
                label: category.name,
                image: category.imagePath,
              ),
              IconButton(
                onPressed: onCardTap,
                icon: const Icon(Icons.arrow_forward_ios),
                // color: AppColors.instance.green100,
              )
            ],
          ),
          Text(
            'Remaining ${remaining.toIndianRupeeWith(decimalPoint: 1)}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
          ),
          LinearProgressBarWidget(
            color: AppColors.instance.primary,
            progressValue: spentAmount / budgetAmount,
          ),
          Text(
            '${spentAmount.toIndianRupeeWith(decimalPoint: 1)} out of ${budgetAmount.toIndianRupeeWith(decimalPoint: 1)}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.instance.dark25.withOpacity(0.8),
            ),
          ),
          if (spentAmount > budgetAmount)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  alertLimit == null
                      ? 'You have exceed the 100% limit!'
                      : alertLimit! < spentAmount
                          ? 'You have exceed the $alertLimit% limit!'
                          : 'You have exceed the 100% limit!',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.red100,
                  ),
                ),
                Icon(
                  Icons.error_outline,
                  color: AppColors.instance.red100,
                )
              ],
            )
        ],
      ),
    );
  }
}

(String label, Color color) getCategoryData(String category) {
  if (category == 'Food') {
    return ('Food', AppColors.instance.red100);
  } else if (category == 'Subscription') {
    return ('Subscription', AppColors.instance.primary);
  } else if (category == 'Transportation') {
    return ('Transportation', AppColors.instance.blue100);
  } else {
    return ('Shopping', AppColors.instance.yellow100);
  }
}
