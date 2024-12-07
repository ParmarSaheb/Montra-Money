import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/app_ui/theme/theme.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/utils/gap.dart';
import 'package:montra_clone/core/utils/size_config.dart';
import 'package:montra_clone/core/widgets/amount_text_field.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/core/widgets/custom_text_field.dart';
import 'package:montra_clone/core/widgets/error_text.dart';
import 'package:montra_clone/modules/categories/bloc/categories_bloc.dart';
import 'package:montra_clone/modules/expense_tracking/bloc/expense_tracker_bloc.dart';
import 'package:montra_clone/modules/expense_tracking/models/transaction_model.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/custom_drop_down_field.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/delete_alert_dialogue.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/delete_button.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/success_dialogue.dart';

@RoutePage()
class ExpenseTrackerScreen extends StatefulWidget implements AutoRouteWrapper {
  const ExpenseTrackerScreen({
    super.key,
    @PathParam() required this.isExpense,
    @PathParam() this.transactionModel,
  });

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();

  final bool isExpense;
  final dynamic transactionModel;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseTrackerBloc(),
      child: this,
    );
  }
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  bool isExpense = false;

  @override
  void initState() {
    super.initState();
    isExpense = widget.isExpense;
    if (widget.transactionModel != null) {
      context.read<ExpenseTrackerBloc>().add(
            EmitSelectedTransactionDetailsEvent(transactionModel: widget.transactionModel),
          );
    }
  }

  Future<void> _showDeleteAlertDialogue(String transactionId, BuildContext buttonContext) {
    return showDialog(
      context: context,
      builder: (context) => DeleteAlertDialogue(
        onNoTap: () => context.maybePop(),
        onDeleteTap: () {
          buttonContext.read<ExpenseTrackerBloc>().add(DeleteTransactionDataEvent(transactionId: transactionId));
          context.maybePop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseTrackerBloc, ExpenseTrackerState>(
      listener: (context, state) async {
        if (state.status == ExpenseTrackerStateStatus.failure) {
          return showToast(
            message: state.errorMessage ?? 'Something went wrong',
            context: context,
            isBehaviourFloating: false,
          );
        } else if (state.status == ExpenseTrackerStateStatus.deleted) {
          await showDialog(
            context: context,
            builder: (context) => SuccessDialogue(
              successMessage: 'Transaction deleted successfully',
              onOkTap: () => context.router
                  .replaceAll([const HomeRoute()], updateExistingRoutes: false),
            ),
          );
        } else if (state.status == ExpenseTrackerStateStatus.success) {
          await showDialog(
            context: context,
            builder: (context) => SuccessDialogue(
              successMessage: 'Data added successfully',
              onOkTap: () => context.router
                  .replaceAll([const HomeRoute()], updateExistingRoutes: false),
            ),
          );
        } else if (state.status == ExpenseTrackerStateStatus.updated) {
          await showDialog(
            context: context,
            builder: (context) => SuccessDialogue(
              successMessage: 'Data updated successfully',
              onOkTap: () => context.router
                  .replaceAll([const HomeRoute()], updateExistingRoutes: false),
            ),
          );
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        color: isExpense ? AppColors.instance.red60 : AppColors.instance.green80,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            titleSpacing: 0,
            title: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => isExpense = false),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 100),
                      opacity: !isExpense ? 1 : 0.7,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isExpense) Icon(Icons.check_circle),
                            HGap(1.w),
                            Text("Income", style: AppTheme.maybeOf(context)?.typography.title18.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => isExpense = true),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 100),
                      opacity: isExpense ? 1 : 0.7,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            if (isExpense) Icon(Icons.check_circle),
                            HGap(1.w),
                            Text("Expense", style: AppTheme.maybeOf(context)?.typography.title18.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                HGap(10.w),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'How much?',
                  style: TextStyle(
                    color: AppColors.instance.light80,
                    fontSize: 18,
                  ),
                ),
              ),
              _AmountTextField(
                transactionModel: widget.transactionModel,
              ),
              const SizedBox(height: 20),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32),
                    ),
                    color: AppColors.instance.light100,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 24,
                      right: 16,
                      left: 16,
                      bottom: 24,
                    ),
                    children: [
                      _CategoryField(
                        isExpense: isExpense,
                        transactionModel: widget.transactionModel,
                      ),
                      _DescriptionField(
                        isExpense: isExpense,
                        transactionModel: widget.transactionModel,
                      ),
                      VGap(3.h),
                      _ContinueButton(
                        isExpense: isExpense,
                        transactionModel: widget.transactionModel,
                      ),
                      if (widget.transactionModel != null)
                        _DeleteButton(
                          transactionModel: widget.transactionModel,
                          showDeleteAlertDialogue: _showDeleteAlertDialogue,
                        ),
                      VGap(1.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AmountTextField extends StatelessWidget {
  const _AmountTextField({super.key, required this.transactionModel});

  final TransactionModel? transactionModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        return AmountTextField(
          initialValue: transactionModel?.transactionAmount,
          onChanged: (value) {
            context.read<ExpenseTrackerBloc>().add(
                  AmountFieldChangeEvent(
                    amount: value,
                  ),
                );
          },
          errorWidget: state.transactionAmount.displayError != null
              ? const Text('Enter the amount')
              : null,
        );
      },
    );
  }
}

class _CategoryField extends StatefulWidget {
  const _CategoryField({
    super.key,
    required this.isExpense,
    required this.transactionModel,
  });

  final bool isExpense;
  final TransactionModel? transactionModel;

  @override
  State<_CategoryField> createState() => _CategoryFieldState();
}

class _CategoryFieldState extends State<_CategoryField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        return CustomDropDownField(
          labelText: 'Category',
          options: context.read<CategoriesBloc>().state.categories.where((e) => e.isIncome == widget.isExpense).toList().map((e) => e.name).toList(),
          selectedValue: widget.transactionModel == null ? state.category : widget.transactionModel!.category,
          onChanged: (value) {
            context.read<ExpenseTrackerBloc>().add(SetCategoryEvent(category: value));
          },
        );
      },
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({
    super.key,
    required this.isExpense,
    required this.transactionModel,
  });

  final bool isExpense;
  final TransactionModel? transactionModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        return CustomTextField(
          initialValue: transactionModel?.description,
          hintText: 'Description',
          isDesc: true,
          errorWidget: state.description.displayError != null ? ErrorText(error: isExpense ? 'Describe where you spend money' : 'Describe the income source') : null,
          onChanged: (value) {
            context.read<ExpenseTrackerBloc>().add(
                  DescriptionFieldChangeEvent(description: value),
                );
          },
        );
      },
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({
    super.key,
    required this.isExpense,
    required this.transactionModel,
  });

  final bool isExpense;
  final TransactionModel? transactionModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        return CustomElevatedButton(
          buttonLabel: AbsorbPointer(
            absorbing: state.status == ExpenseTrackerStateStatus.loading ||
                    state.status == ExpenseTrackerStateStatus.updateLoading
                ? true
                : false,
            child: state.status == ExpenseTrackerStateStatus.loading || state.status == ExpenseTrackerStateStatus.updateLoading
                ? CircularProgressIndicator(
                    color: AppColors.instance.light100,
                  )
                : ButtonTitle(
                    isPurple: true,
                    buttonLabel: transactionModel == null ? 'Continue' : 'Update',
                  ),
          ),
          isPurple: true,
          color: isExpense ? AppTheme.maybeOf(context)?.colors.red100 : AppTheme.maybeOf(context)?.colors.green100,
          onPressed: state.status == ExpenseTrackerStateStatus.loading || state.status == ExpenseTrackerStateStatus.updateLoading
              ? () {}
              : () {
                  transactionModel == null
                      ? context.read<ExpenseTrackerBloc>().add(AddTransactionToFireStoreEvent(isExpense: isExpense))
                      : context.read<ExpenseTrackerBloc>().add(
                            UpdateTransactionDataEvent(
                              transactionId: transactionModel!.transactionId,
                            ),
                          );
                },
        );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton(
      {super.key,
      required this.transactionModel,
      required this.showDeleteAlertDialogue});

  final TransactionModel transactionModel;
  final Function(String transactionId, BuildContext context)
      showDeleteAlertDialogue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        return DeleteButton(
          buttonLabel:
              state.status == ExpenseTrackerStateStatus.deleteDataLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.instance.red100,
                      ),
                    ),
          onPressed: () {
            showDeleteAlertDialogue(transactionModel.transactionId, context);
          },
        );
      },
    );
  }
}
