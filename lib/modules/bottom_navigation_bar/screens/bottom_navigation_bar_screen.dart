import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/gap.dart';
import 'package:montra_clone/core/utils/size_config.dart';
import 'package:montra_clone/modules/bottom_navigation_bar/cubit/configuration_cubit.dart';
import 'package:montra_clone/modules/bottom_navigation_bar/widgets/add_transaction_buttton.dart';
import 'package:montra_clone/modules/categories/bloc/categories_bloc.dart';
import 'package:montra_clone/modules/transaction/bloc/transaction_bloc.dart';

@RoutePage()
class BottomNavigationBarScreen extends StatefulWidget implements AutoRouteWrapper {
  const BottomNavigationBarScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfigurationCubit(),
      child: this,
    );
  }

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(LoadCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        TransactionRoute(),
        EmptyRoute(),
        BudgetRoute(),
        ProfileRoute(),
      ],
      homeIndex: 0,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          extendBody: true,
          body: child,
          bottomNavigationBar: BottomAppBar(
            notchMargin: 0,
            padding: EdgeInsets.zero,
            color: AppColors.instance.light100,
            shape: const CircularNotchedRectangle(),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      BottomAppBarItem(
                        imagePath: tabsRouter.activeIndex == 0 ? homeActiveIconPath : homeInactiveIconPath,
                        label: 'Home',
                        onTap: () {
                          tabsRouter.setActiveIndex(0);
                        },
                      ),
                      BottomAppBarItem(
                        imagePath: tabsRouter.activeIndex == 1 ? transactionActiveIconPath : transactionInactiveIconPath,
                        label: 'Transaction',
                        onTap: () {
                          tabsRouter.setActiveIndex(1);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Row(
                    children: [
                      BottomAppBarItem(
                        imagePath: tabsRouter.activeIndex == 3 ? pieChartActiveIconPath : pieChartInactiveIconPath,
                        label: 'Budget',
                        onTap: () {
                          tabsRouter.setActiveIndex(3);
                        },
                      ),
                      BottomAppBarItem(
                        imagePath: tabsRouter.activeIndex == 4 ? userActiveIconPath : userInactiveIconPath,
                        label: 'Profile',
                        onTap: () {
                          tabsRouter.setActiveIndex(4);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: const AddTransactionButton(),
        );
      },
    );
  }
}

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  final String imagePath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VGap(1.h),
            Expanded(
              child: SvgPicture.asset(
                imagePath,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 1.h), child: Text(label)),
          ],
        ),
      ),
    );
  }
}
