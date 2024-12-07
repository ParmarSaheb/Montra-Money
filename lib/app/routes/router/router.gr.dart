// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i24;
import 'package:flutter/material.dart' as _i25;
import 'package:montra_clone/app/routes/router/router.dart' as _i9;
import 'package:montra_clone/modules/authentication/login/screens/login_screen.dart'
    as _i15;
import 'package:montra_clone/modules/authentication/signup/screens/signup_screen.dart'
    as _i19;
import 'package:montra_clone/modules/authentication/signup/screens/verification_info_screen.dart'
    as _i22;
import 'package:montra_clone/modules/bottom_navigation_bar/screens/bottom_navigation_bar_screen.dart'
    as _i2;
import 'package:montra_clone/modules/budget/screens/budget_screen.dart' as _i3;
import 'package:montra_clone/modules/budget/screens/create_budget_screen.dart'
    as _i5;
import 'package:montra_clone/modules/budget/screens/detail_budget_screen.dart'
    as _i7;
import 'package:montra_clone/modules/categories/screens/categories_screen.dart'
    as _i4;
import 'package:montra_clone/modules/credential_recover/screens/forgot_password_screen.dart'
    as _i12;
import 'package:montra_clone/modules/expense_tracking/screens/expense_tracker_screen.dart'
    as _i10;
import 'package:montra_clone/modules/financial_analysis/screens/analysis_screen.dart'
    as _i1;
import 'package:montra_clone/modules/financial_report/screens/financial_report_screen.dart'
    as _i11;
import 'package:montra_clone/modules/home/screens/home_screen.dart' as _i13;
import 'package:montra_clone/modules/home/screens/view_all_data_screen.dart'
    as _i23;
import 'package:montra_clone/modules/onboarding/screens/onboarding_screen.dart'
    as _i16;
import 'package:montra_clone/modules/profile/screens/edit_user_info_screen.dart'
    as _i8;
import 'package:montra_clone/modules/profile/screens/profile_screen.dart'
    as _i17;
import 'package:montra_clone/modules/settings/screens/currency_screen.dart'
    as _i6;
import 'package:montra_clone/modules/settings/screens/language_screen.dart'
    as _i14;
import 'package:montra_clone/modules/settings/screens/setting_screen.dart'
    as _i18;
import 'package:montra_clone/modules/splash_screen.dart' as _i20;
import 'package:montra_clone/modules/transaction/screens/transaction_screen.dart'
    as _i21;

/// generated route for
/// [_i1.AnalysisScreen]
class AnalysisRoute extends _i24.PageRouteInfo<void> {
  const AnalysisRoute({List<_i24.PageRouteInfo>? children})
      : super(
          AnalysisRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnalysisRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i1.AnalysisScreen());
    },
  );
}

/// generated route for
/// [_i2.BottomNavigationBarScreen]
class BottomNavigationBarRoute extends _i24.PageRouteInfo<void> {
  const BottomNavigationBarRoute({List<_i24.PageRouteInfo>? children})
      : super(
          BottomNavigationBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavigationBarRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i2.BottomNavigationBarScreen());
    },
  );
}

/// generated route for
/// [_i3.BudgetScreen]
class BudgetRoute extends _i24.PageRouteInfo<void> {
  const BudgetRoute({List<_i24.PageRouteInfo>? children})
      : super(
          BudgetRoute.name,
          initialChildren: children,
        );

  static const String name = 'BudgetRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i3.BudgetScreen());
    },
  );
}

/// generated route for
/// [_i4.CategoriesScreen]
class CategoriesRoute extends _i24.PageRouteInfo<void> {
  const CategoriesRoute({List<_i24.PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i4.CategoriesScreen());
    },
  );
}

/// generated route for
/// [_i5.CreateBudgetScreen]
class CreateBudgetRoute extends _i24.PageRouteInfo<CreateBudgetRouteArgs> {
  CreateBudgetRoute({
    _i25.Key? key,
    dynamic budgetModel,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          CreateBudgetRoute.name,
          args: CreateBudgetRouteArgs(
            key: key,
            budgetModel: budgetModel,
          ),
          rawPathParams: {'budgetModel': budgetModel},
          initialChildren: children,
        );

  static const String name = 'CreateBudgetRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CreateBudgetRouteArgs>(
          orElse: () => CreateBudgetRouteArgs(
              budgetModel: pathParams.get('budgetModel')));
      return _i24.WrappedRoute(
          child: _i5.CreateBudgetScreen(
        key: args.key,
        budgetModel: args.budgetModel,
      ));
    },
  );
}

class CreateBudgetRouteArgs {
  const CreateBudgetRouteArgs({
    this.key,
    this.budgetModel,
  });

  final _i25.Key? key;

  final dynamic budgetModel;

  @override
  String toString() {
    return 'CreateBudgetRouteArgs{key: $key, budgetModel: $budgetModel}';
  }
}

/// generated route for
/// [_i6.CurrencyScreen]
class CurrencyRoute extends _i24.PageRouteInfo<void> {
  const CurrencyRoute({List<_i24.PageRouteInfo>? children})
      : super(
          CurrencyRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrencyRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i6.CurrencyScreen());
    },
  );
}

/// generated route for
/// [_i7.DetailBudgetScreen]
class DetailBudgetRoute extends _i24.PageRouteInfo<DetailBudgetRouteArgs> {
  DetailBudgetRoute({
    _i25.Key? key,
    required dynamic budgetModel,
    required double spentAmount,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          DetailBudgetRoute.name,
          args: DetailBudgetRouteArgs(
            key: key,
            budgetModel: budgetModel,
            spentAmount: spentAmount,
          ),
          rawPathParams: {
            'budgetModel': budgetModel,
            'spentAmount': spentAmount,
          },
          initialChildren: children,
        );

  static const String name = 'DetailBudgetRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<DetailBudgetRouteArgs>(
          orElse: () => DetailBudgetRouteArgs(
                budgetModel: pathParams.get('budgetModel'),
                spentAmount: pathParams.getDouble('spentAmount'),
              ));
      return _i24.WrappedRoute(
          child: _i7.DetailBudgetScreen(
        key: args.key,
        budgetModel: args.budgetModel,
        spentAmount: args.spentAmount,
      ));
    },
  );
}

class DetailBudgetRouteArgs {
  const DetailBudgetRouteArgs({
    this.key,
    required this.budgetModel,
    required this.spentAmount,
  });

  final _i25.Key? key;

  final dynamic budgetModel;

  final double spentAmount;

  @override
  String toString() {
    return 'DetailBudgetRouteArgs{key: $key, budgetModel: $budgetModel, spentAmount: $spentAmount}';
  }
}

/// generated route for
/// [_i8.EditUserInfoScreen]
class EditUserInfoRoute extends _i24.PageRouteInfo<EditUserInfoRouteArgs> {
  EditUserInfoRoute({
    _i25.Key? key,
    required String name,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          EditUserInfoRoute.name,
          args: EditUserInfoRouteArgs(
            key: key,
            name: name,
          ),
          rawPathParams: {'name': name},
          initialChildren: children,
        );

  static const String name = 'EditUserInfoRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EditUserInfoRouteArgs>(
          orElse: () =>
              EditUserInfoRouteArgs(name: pathParams.getString('name')));
      return _i24.WrappedRoute(
          child: _i8.EditUserInfoScreen(
        key: args.key,
        name: args.name,
      ));
    },
  );
}

class EditUserInfoRouteArgs {
  const EditUserInfoRouteArgs({
    this.key,
    required this.name,
  });

  final _i25.Key? key;

  final String name;

  @override
  String toString() {
    return 'EditUserInfoRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i9.EmptyScreen]
class EmptyRoute extends _i24.PageRouteInfo<void> {
  const EmptyRoute({List<_i24.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i9.EmptyScreen();
    },
  );
}

/// generated route for
/// [_i10.ExpenseTrackerScreen]
class ExpenseTrackerRoute extends _i24.PageRouteInfo<ExpenseTrackerRouteArgs> {
  ExpenseTrackerRoute({
    _i25.Key? key,
    required bool isExpense,
    dynamic transactionModel,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          ExpenseTrackerRoute.name,
          args: ExpenseTrackerRouteArgs(
            key: key,
            isExpense: isExpense,
            transactionModel: transactionModel,
          ),
          rawPathParams: {
            'isExpense': isExpense,
            'transactionModel': transactionModel,
          },
          initialChildren: children,
        );

  static const String name = 'ExpenseTrackerRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ExpenseTrackerRouteArgs>(
          orElse: () => ExpenseTrackerRouteArgs(
                isExpense: pathParams.getBool('isExpense'),
                transactionModel: pathParams.get('transactionModel'),
              ));
      return _i24.WrappedRoute(
          child: _i10.ExpenseTrackerScreen(
        key: args.key,
        isExpense: args.isExpense,
        transactionModel: args.transactionModel,
      ));
    },
  );
}

class ExpenseTrackerRouteArgs {
  const ExpenseTrackerRouteArgs({
    this.key,
    required this.isExpense,
    this.transactionModel,
  });

  final _i25.Key? key;

  final bool isExpense;

  final dynamic transactionModel;

  @override
  String toString() {
    return 'ExpenseTrackerRouteArgs{key: $key, isExpense: $isExpense, transactionModel: $transactionModel}';
  }
}

/// generated route for
/// [_i11.FinancialReportScreen]
class FinancialReportRoute extends _i24.PageRouteInfo<void> {
  const FinancialReportRoute({List<_i24.PageRouteInfo>? children})
      : super(
          FinancialReportRoute.name,
          initialChildren: children,
        );

  static const String name = 'FinancialReportRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i11.FinancialReportScreen());
    },
  );
}

/// generated route for
/// [_i12.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i24.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i12.ForgotPasswordScreen());
    },
  );
}

/// generated route for
/// [_i13.HomeScreen]
class HomeRoute extends _i24.PageRouteInfo<void> {
  const HomeRoute({List<_i24.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i13.HomeScreen());
    },
  );
}

/// generated route for
/// [_i14.LanguageScreen]
class LanguageRoute extends _i24.PageRouteInfo<void> {
  const LanguageRoute({List<_i24.PageRouteInfo>? children})
      : super(
          LanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i14.LanguageScreen());
    },
  );
}

/// generated route for
/// [_i15.LoginScreen]
class LoginRoute extends _i24.PageRouteInfo<void> {
  const LoginRoute({List<_i24.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i15.LoginScreen());
    },
  );
}

/// generated route for
/// [_i16.OnboardingScreen]
class OnboardingRoute extends _i24.PageRouteInfo<void> {
  const OnboardingRoute({List<_i24.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i16.OnboardingScreen());
    },
  );
}

/// generated route for
/// [_i17.ProfileScreen]
class ProfileRoute extends _i24.PageRouteInfo<void> {
  const ProfileRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i17.ProfileScreen());
    },
  );
}

/// generated route for
/// [_i18.SettingScreen]
class SettingRoute extends _i24.PageRouteInfo<void> {
  const SettingRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i18.SettingScreen());
    },
  );
}

/// generated route for
/// [_i19.SignupScreen]
class SignupRoute extends _i24.PageRouteInfo<void> {
  const SignupRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i19.SignupScreen());
    },
  );
}

/// generated route for
/// [_i20.SplashScreen]
class SplashRoute extends _i24.PageRouteInfo<void> {
  const SplashRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i20.SplashScreen();
    },
  );
}

/// generated route for
/// [_i21.TransactionScreen]
class TransactionRoute extends _i24.PageRouteInfo<void> {
  const TransactionRoute({List<_i24.PageRouteInfo>? children})
      : super(
          TransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i21.TransactionScreen());
    },
  );
}

/// generated route for
/// [_i22.VerificationInfoScreen]
class VerificationInfoRoute extends _i24.PageRouteInfo<void> {
  const VerificationInfoRoute({List<_i24.PageRouteInfo>? children})
      : super(
          VerificationInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerificationInfoRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i22.VerificationInfoScreen();
    },
  );
}

/// generated route for
/// [_i23.ViewAllDataScreen]
class ViewAllDataRoute extends _i24.PageRouteInfo<void> {
  const ViewAllDataRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ViewAllDataRoute.name,
          initialChildren: children,
        );

  static const String name = 'ViewAllDataRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return _i24.WrappedRoute(child: const _i23.ViewAllDataScreen());
    },
  );
}
