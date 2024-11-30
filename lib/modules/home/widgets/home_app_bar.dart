import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/image_paths.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.instance.yellow20,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                appLogo,
                height: 70,
                width: 140,
              ),
              Icon(
                Icons.notifications,
                size: 35,
                color: AppColors.instance.violet80,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 60);
}
