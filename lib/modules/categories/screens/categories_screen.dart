import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/category_png_icons.dart';
import 'package:montra_clone/app_ui/theme/theme.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/utils/gap.dart';
import 'package:montra_clone/core/utils/size_config.dart';
import 'package:montra_clone/modules/budget/bloc/budget_bloc.dart';
import 'package:montra_clone/modules/categories/bloc/categories_bloc.dart';
import 'package:montra_clone/modules/categories/widgets/add_edit_new_category.dart';

@RoutePage()
class CategoriesScreen extends StatefulWidget implements AutoRouteWrapper {
  const CategoriesScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>()..add(LoadCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == BudgetStateStatus.failure) {
          showToast(message: state.errorMessage, context: context, isBehaviourFloating: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.instance.light100,
          appBar: AppBar(
            backgroundColor: AppColors.instance.light100,
            centerTitle: true,
            title: const Text('Categories'),
          ),
          floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () => AddEditNewCategory().showSheet(context)),
          body: Builder(builder: (context) {
            if (state.status == CategoriesStateStatus.loading) return Center(child: CircularProgressIndicator(color: AppColors.instance.primary));
            if (state.categories.isEmpty)
              return Center(
                child: Text("No Categories found.!"),
              );
            return RefreshIndicator(
              onRefresh: () async {
                final cates = await context.read<CategoriesBloc>().getCategories;
                context.read<CategoriesBloc>().add(UpdateStateCategoriesEvent(state.copyWith(categories: cates)));
              },
              child: Scrollbar(
                child: ListView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.incomeCategories.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Text("Income Categories", style: AppTheme.maybeOf(context)?.typography.title18),
                          ),
                        VGap(1.h),
                        ...List.generate(
                          state.incomeCategories.length,
                          (index) {
                            final c = state.incomeCategories[index];
                            return ListTile(
                              leading: Image.asset(c.imagePath, height: 10.w, width: 10.w),
                              title: Text(c.name, style: AppTheme.maybeOf(context)?.typography.regular14),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text("Edit"),
                                      onTap: () => AddEditNewCategory(category: c, selectedIcon: c.imagePath.getIcon).showSheet(context),
                                    ),
                                    PopupMenuItem(
                                      child: Text("Delete"),
                                      onTap: () => context.read<CategoriesBloc>().add(DeleteCategoryEvent(id: c.id)),
                                    ),
                                  ];
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    if (state.expenseCategories.isNotEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Text("Expense Categories", style: AppTheme.maybeOf(context)?.typography.title18),
                          ),
                          VGap(1.h),
                          ...List.generate(
                            state.expenseCategories.length,
                            (index) {
                              final c = state.expenseCategories[index];
                              return ListTile(
                                leading: Image.asset(c.imagePath, height: 10.w, width: 10.w),
                                title: Text(c.name, style: AppTheme.maybeOf(context)?.typography.regular14),
                                trailing: PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text("Edit"),
                                        onTap: () => AddEditNewCategory(category: c, selectedIcon: c.imagePath.getIcon).showSheet(context),
                                      ),
                                      PopupMenuItem(
                                        child: Text("Delete"),
                                        onTap: () => context.read<CategoriesBloc>().add(DeleteCategoryEvent(id: c.id)),
                                      ),
                                    ];
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    VGap(10.h),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
