import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/category_png_icons.dart';
import 'package:montra_clone/app_ui/theme/theme.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/utils/gap.dart';
import 'package:montra_clone/core/utils/size_config.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/core/widgets/custom_text_field.dart';
import 'package:montra_clone/modules/categories/models/category_model.dart';

import '../bloc/categories_bloc.dart';

class AddEditNewCategory extends StatefulWidget {
  final CategoryPngIcons? selectedIcon;
  final CategoryModel? category;

  const AddEditNewCategory({super.key, this.category, this.selectedIcon});

  @override
  State<AddEditNewCategory> createState() => _AddEditNewCategoryState();

  Future showSheet(BuildContext context) => showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        isScrollControlled: true,
        builder: (context) {
          return Padding(
              padding: EdgeInsets.only(
                left: 3.w,
                right: 3.w,
                top: 2.h,
                bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
              ),
              child: this);
        },
      );
}

class _AddEditNewCategoryState extends State<AddEditNewCategory> {
  late CategoryPngIcons selectedIcon;
  String categoryName = '';
  bool isIncome = true;

  @override
  void initState() {
    super.initState();
    selectedIcon = widget.selectedIcon ?? CategoryPngIcons.values.first;
    if (widget.category != null) {
      categoryName = widget.category!.name;
      selectedIcon = widget.category!.imagePath.getIcon;
      isIncome = widget.category!.isIncome;
    }
  }

  bool get isEdit => widget.category != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${isEdit ? "Edit" : "Add"} New Category", style: AppTheme.maybeOf(context)?.typography.title18),
        VGap(1.5.h),
        Row(
          children: [
            Text("Type : ", style: AppTheme.maybeOf(context)?.typography.regular16),
            HGap(3.w),
            InkWell(
              onTap: () => setState(() => isIncome = true),
              child: Center(
                  child: AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: isIncome ? 1 : 0.5,
                child: Row(
                  children: [
                    if (isIncome) Icon(Icons.check_circle),
                    HGap(1.w),
                    Text("Income", style: AppTheme.maybeOf(context)?.typography.title18),
                  ],
                ),
              )),
            ),
            HGap(5.w),
            InkWell(
              onTap: () => setState(() => isIncome = false),
              child: Center(
                  child: AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: !isIncome ? 1 : 0.5,
                child: Row(
                  children: [
                    if (!isIncome) Icon(Icons.check_circle),
                    HGap(1.w),
                    Text("Expense", style: AppTheme.maybeOf(context)?.typography.title18),
                  ],
                ),
              )),
            ),
            Expanded(child: SizedBox())
          ],
        ),
        VGap(1.5.h),
        CustomTextField(
          hintText: "Enter category name",
          errorWidget: null,
          onChanged: (v) => categoryName = v.trim(),
          initialValue: categoryName,
          autoFocus: true,
        ),
        VGap(1.5.h),
        Container(
          height: 16.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            mainAxisSpacing: 2.w,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
            crossAxisSpacing: 2.w,
            children: [
              ...List.generate(
                CategoryModel.allCategories.length,
                (index) {
                  final c = CategoryModel.allCategories[index];
                  return InkWell(
                    onTap: () => setState(() => selectedIcon = c.imagePath.getIcon),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: selectedIcon.path == c.imagePath ? AppTheme.maybeOf(context)?.colors.primary.withOpacity(0.4) : null,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage(c.imagePath), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        VGap(1.5.h),
        Row(
          children: [
            Expanded(child: CustomElevatedButton(buttonLabel: Text("Cancel", style: AppTheme.maybeOf(context)?.typography.regular16), isPurple: false, onPressed: () => context.maybePop())),
            HGap(2.w),
            Expanded(
              child: CustomElevatedButton(
                buttonLabel: Text("Save", style: AppTheme.maybeOf(context)?.typography.regular16.copyWith(color: Colors.white)),
                isPurple: true,
                onPressed: () {
                  if (categoryName.trim() == "") {
                    showToast(message: "Please enter category name.!", context: context, isBehaviourFloating: true);
                    return;
                  }
                  context.maybePop();
                  context.read<CategoriesBloc>().add(AddEditCategoriesEvent(
                        updatableCategoryId: widget.category?.id,
                        icon: selectedIcon,
                        name: categoryName,
                        isIncome: isIncome,
                      ));
                  context.maybePop();
                },
              ),
            ),
          ],
        ),
        VGap(1.h),
      ],
    );
  }
}
