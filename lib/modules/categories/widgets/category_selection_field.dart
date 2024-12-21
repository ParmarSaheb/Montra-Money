import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app_ui/theme/theme.dart';
import 'package:montra_clone/core/utils/devlog.dart';
import 'package:montra_clone/core/utils/gap.dart';
import 'package:montra_clone/core/utils/size_config.dart';
import 'package:montra_clone/modules/categories/bloc/categories_bloc.dart';
import 'package:montra_clone/modules/categories/widgets/add_edit_new_category.dart';
import 'package:montra_clone/modules/expense_tracking/bloc/expense_tracker_bloc.dart';
import 'package:montra_clone/modules/expense_tracking/models/transaction_model.dart';

import '../../categories/models/category_model.dart';

class CategorySelectionField extends StatefulWidget {
  const CategorySelectionField({
    required this.cates,
    required this.isExpense,
    this.transactionModel,
    required String? selectedCategoryId,
    required this.onSelect,
  }): _selectedCategoryId = selectedCategoryId;

  final String? _selectedCategoryId;
  final List<CategoryModel> cates;
  final bool isExpense;
  final TransactionModel? transactionModel;
  final void Function(CategoryModel category) onSelect;

  String? get selectedCategoryId => (_selectedCategoryId ?? "") == "" ? null : _selectedCategoryId;

  @override
  State<CategorySelectionField> createState() => _CategorySelectionFieldState();
}

class _CategorySelectionFieldState extends State<CategorySelectionField> {
  @override
  Widget build(BuildContext context) {
    devlog("selectedCategoryId : ${widget.selectedCategoryId} : ${widget.cates.map((e) => e.name)}");
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5.w),
          child: Text("Category"),
        ),
        VGap(0.3.h),
        InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (ctx) {
                return Container(
                  constraints: BoxConstraints(maxHeight: 70.h),
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (ctx, cateState) {
                      final categories = cateState.categories.where((e) => !e.isIncome == widget.isExpense).toList();
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VGap(3.h),
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 4,
                            mainAxisSpacing: 3.w,
                            crossAxisSpacing: 3.w,
                            children: categories
                                .map((e) => InkWell(
                                      onTap: () {
                                        widget.onSelect(e);
                                        ctx.maybePop();
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: ((widget.transactionModel == null ? widget.selectedCategoryId : widget.transactionModel!.category!.id) == e.id)
                                                ? widget.isExpense
                                                    ? AppColors.instance.red20
                                                    : AppColors.instance.green20
                                                : null),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            VGap(0.3.h),
                                            Expanded(
                                              child: Image.asset(
                                                e.imagePath,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 0.3.h),
                                              child: Text(e.name, style: AppTheme.maybeOf(context)?.typography.regular14, maxLines: 1, overflow: TextOverflow.ellipsis),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          OutlinedButton(
                              onPressed: () async {
                                await AddEditNewCategory(isIncome: !widget.isExpense).showSheet(context);
                                context.read<CategoriesBloc>().add(LoadCategoriesEvent());
                              },
                              child: Text("Add New Category")),
                          VGap(3.h),
                        ],
                      );
                    },
                  ),
                );
              },
            );
          },
          child: Container(
            height: 6.h,
            margin: EdgeInsets.only(bottom: 2.h),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            child: widget.selectedCategoryId == null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Text("--Select Category--"),
                  )
                : Builder(builder: (context) {
                    try {
                      return Row(
                        children: [
                          HGap(2.w),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.2.h),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                widget.cates.firstWhere((e) => e.id == widget.selectedCategoryId).imagePath,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Text(widget.cates.firstWhere((e) => e.id == widget.selectedCategoryId).name,
                                style: AppTheme.maybeOf(context)?.typography.regular14, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      );
                    } catch (e) {
                      return Text("Error : $e");
                    }
                  }),
          ),
        ),
      ],
    );
  }
}
