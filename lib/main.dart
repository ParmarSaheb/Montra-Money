import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra_clone/app/routes/router/router.dart';
import 'package:montra_clone/app_ui/theme/responsive_theme.dart';
import 'package:montra_clone/app_ui/theme/theme_bloc.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/firebase_options.dart';
import 'package:montra_clone/modules/categories/bloc/categories_bloc.dart';
import 'package:montra_clone/modules/home/bloc/home_bloc.dart';

import 'core/utils/logging_bloc_observer.dart';
import 'core/utils/size_config.dart';
import 'modules/expense_tracking/bloc/expense_tracker_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, name: 'Updated');
  Bloc.observer = LoggingBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => CategoriesBloc()..add(LoadCategoriesEvent())),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  App({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SizeConfig.init(context);
    return AppResponsiveTheme(
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, AppThemeColorMode>(
          builder: (BuildContext context, AppThemeColorMode themeMode) {
            return RepositoryProvider(
              create: (context) => AuthenticationRepository(),
              child: MaterialApp.router(
                routerConfig: _router.config(),
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: child!,
                  );
                },
                theme: ThemeData(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  appBarTheme: AppBarTheme.of(context).copyWith(scrolledUnderElevation: 0, backgroundColor: Colors.transparent)
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
