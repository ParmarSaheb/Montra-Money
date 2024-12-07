import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app/app_colors.dart';

showToast({
  required String message,
  BuildContext ? context,
  bool? isBehaviourFloating,
  String? bgColor,
  String? color,
}) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      // backgroundColor: Colors.getWhite(context),
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 16,
      backgroundColor: AppColors.instance.dark75,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM);
}
