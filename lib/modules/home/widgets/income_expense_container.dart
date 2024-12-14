import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app_ui/theme/theme.dart';
import 'package:montra_clone/core/extensions/to_indian_rupee_extension.dart';
import 'package:montra_clone/modules/home/widgets/price_card.dart';

class IncomeExpenseContainer extends StatelessWidget {
  const IncomeExpenseContainer({
    super.key,
    required this.totalBudget,
    required this.income,
    required this.expense,
  });

  final double totalBudget;
  final double income;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * (0.25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.instance.yellow20,
            AppColors.instance.yellow20.withOpacity(0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Total Balance',
              style: TextStyle(
                color: AppColors.instance.dark25,
                fontSize: 15,
                // fontFamily:
              ),
            ),
            Text(
              totalBudget >= 0 ? '${totalBudget.toIndianRupee}'
                  : '-${totalBudget.abs().toIndianRupee}',
              style: AppTheme.maybeOf(context)?.typography.title32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PriceCard(
                  iconPath: incomeIcon,
                  color: AppColors.instance.green100,
                  label: 'Income',
                  price: '${income.toIndianRupeeWith(decimalPoint: 1)}',
                ),
                PriceCard(
                  iconPath: expenseIcon,
                  color: AppColors.instance.red100,
                  label: 'Expenses',
                  price: '${expense.toIndianRupeeWith(decimalPoint: 1)}',
                ),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
