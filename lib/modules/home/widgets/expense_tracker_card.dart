import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app_ui/theme/theme.dart';
import 'package:montra_clone/core/extensions/to_indian_rupee_extension.dart';
import 'package:montra_clone/core/utils/gap.dart';
import 'package:montra_clone/core/utils/size_config.dart';

import '../../categories/models/category_model.dart';

class ExpenseTrackerCard extends StatelessWidget {
  const ExpenseTrackerCard({
    super.key,
    required this.category,
    required this.isExpense,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.onCardTap,
  });

  final CategoryModel? category;
  final bool isExpense;
  final String amount;
  final String description;
  final String createdAt;
  final VoidCallback onCardTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        padding: EdgeInsets.all(7),
        margin: EdgeInsets.all(2.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.instance.yellow20.withOpacity(0.2),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                // color: !isExpense ? AppColors.instance.green20 : AppColors.instance.red20,
                borderRadius: BorderRadius.circular(14.5),
              ),
              child: Image.asset(
                category?.imagePath ?? "",
                height: 10.w,
                width: 10.w,
                fit: BoxFit.fill,
              ),
            ),
            HGap(3.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category?.name ?? "--",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTheme.maybeOf(context)?.typography.regular16,
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTheme.maybeOf(context)?.typography.regular14.copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${isExpense ? '-' : '+'}${amount.toIndianRupee}",
                    style: TextStyle(
                      color: isExpense ? AppColors.instance.red100 : AppColors.instance.green100,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    createdAt,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
