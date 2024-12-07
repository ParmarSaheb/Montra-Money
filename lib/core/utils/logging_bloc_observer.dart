import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoggingBlocObserver extends BlocObserver {
  String truncateData(dynamic data) {
    String dataString = data?.toString() ?? '';
    return dataString.length > 2000 ? dataString.substring(0, 2000) + '...' : dataString;
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log(
      "-----------------[ EVENT ]------------------------\n"
      "[🔵 BLOC NAME    ] : ${bloc.runtimeType} \n"
      "[🔵 EVENT NAME   ] : ${event.runtimeType} \n"
      "[🔵 EVENT DATA   ] : ${truncateData(event)} \n"
      "-----------------------------------------------------------------------------\n",
      name: "🔵 BLOC EVENT ",
    );

    if (kReleaseMode) {
      print(
        "-----------------[ EVENT ]------------------------\n"
        "[ BLOC NAME    ] : ${bloc.runtimeType} \n"
        "[ EVENT NAME   ] : ${event.runtimeType} \n"
        "[ EVENT DATA   ] : ${truncateData(event)} \n"
        "-----------------------------------------------------------------------------\n",
      );
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
      "-----------------[ TRANSITION ]------------------------\n"
      "[🟢 BLOC NAME      ] : ${bloc.runtimeType} \n"
      "[🟢 EVENT TRIGGERED] : ${transition.event.runtimeType} \n"
      "[🟢 CURRENT STATE  ] : ${truncateData(transition.currentState)} \n"
      "[🟢 NEXT STATE     ] : ${truncateData(transition.nextState)} \n"
      "-----------------------------------------------------------------------------\n",
      name: "🟢 BLOC TRANSITION ",
    );

    if (kReleaseMode) {
      print(
        "-----------------[ TRANSITION ]------------------------\n"
        "[ BLOC NAME      ] : ${bloc.runtimeType} \n"
        "[ EVENT TRIGGERED] : ${transition.event.runtimeType} \n"
        "[ CURRENT STATE  ] : ${truncateData(transition.currentState)} \n"
        "[ NEXT STATE     ] : ${truncateData(transition.nextState)} \n"
        "-----------------------------------------------------------------------------\n",
      );
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      "-----------------[ ERROR ]------------------------\n"
      "[🔴 BLOC NAME    ] : ${bloc.runtimeType} \n"
      "[🔴 ERROR TYPE   ] : ${error.runtimeType} \n"
      "[🔴 ERROR MESSAGE] : ${truncateData(error)} \n"
      "-----------------------------------------------------------------------------\n",
      name: "🔴 BLOC ERROR ",
    );

    if (kReleaseMode) {
      print(
        "-----------------[ ERROR ]------------------------\n"
        "[ BLOC NAME    ] : ${bloc.runtimeType} \n"
        "[ ERROR TYPE   ] : ${error.runtimeType} \n"
        "[ ERROR MESSAGE] : ${truncateData(error)} \n"
        "-----------------------------------------------------------------------------\n",
      );
    }
  }
}
