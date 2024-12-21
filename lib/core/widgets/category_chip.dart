import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app_ui/theme/theme.dart';

import '../../modules/categories/widgets/category_image.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    this.color,
    this.image,
    required this.label,
  });

  final Color? color;
  final String? image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: AppColors.instance.light20,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(color != null)
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
            if(image != null)
              CategoryImage(image!, height: 25, width: 25),

            const SizedBox(width: 8),
            Text(
              label,
              style: context.textTheme?.regular16.copyWith(fontWeight: FontWeight.w400),
            )
          ],
        ));
  }
}
