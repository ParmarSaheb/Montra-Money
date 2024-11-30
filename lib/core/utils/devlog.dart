import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

void devlog(String msg, {String? name}) {
  dev.log("--> --> -->  $msg", name: name ?? " LOG ");
  if (kReleaseMode) print("--> --> -->  $msg");
}

void devlogError(String error) {
  dev.log("==> ==> ==> * $error", name: " ERROR ");
  if (kReleaseMode) print("==> ==> ==> * $error");
}

void devlogApi(String msg) {
  dev.log(" == == == >>> $msg", name: "[ API LOG ]");
  if (kReleaseMode) print(" == == == >>> $msg");
}