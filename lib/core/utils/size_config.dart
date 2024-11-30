import 'dart:math';

import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  bool get isMobile => screenWidth < 768;

  bool get isTablet => screenWidth >= 768 && screenWidth < 1200;

  bool get isDesktop => screenWidth >= 1200;

  T value<T>({
    required T mobile,
    required T? tablet,
    required T? desktop,
  }) {
    if (isMobile) return mobile;
    if (isTablet) return tablet ?? mobile;
    return desktop ?? mobile;
  }

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

extension SizeConfigByContext on BuildContext {
  double w(double w) => w * (MediaQuery.of(this).size.width / 100);

  double h(double h) => h * (MediaQuery.of(this).size.height / 100);

  double t(double t) {
    final diagonalSize =
        sqrt(MediaQuery.of(this).size.width * MediaQuery.of(this).size.width + MediaQuery.of(this).size.height * MediaQuery.of(this).size.height); // Calculating diagonal size of the screen
    final scaleFactor = diagonalSize / 100; // Normalized diagonal size scaling
    return t * scaleFactor;
  }

  double r(double r) {
    final averageBlockSize = ((MediaQuery.of(this).size.width / 100) + (MediaQuery.of(this).size.height / 100)) / 2;
    return r * averageBlockSize; // Using average for consistent square scaling
  }
}

extension SizeConfigExtension on num {
  double get w => this * SizeConfig.blockSizeHorizontal;

  double get h => this * SizeConfig.blockSizeVertical;

  double get t {
    final diagonalSize = sqrt(SizeConfig.screenWidth * SizeConfig.screenWidth + SizeConfig.screenHeight * SizeConfig.screenHeight); // Calculating diagonal size of the screen
    final scaleFactor = diagonalSize / 100; // Normalized diagonal size scaling
    final size =(this * scaleFactor) ;
    return size.isNegative ? 1 : size;

  }

  double get r {
    final averageBlockSize = (SizeConfig.blockSizeHorizontal + SizeConfig.blockSizeVertical) / 2;
    final size = (this * averageBlockSize) - 3;
    return size.isNegative ? 0 : size; // Using average for consistent square scaling
  }
}