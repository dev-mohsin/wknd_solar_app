import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wknd_app/config/router/app_router.dart';
import 'package:wknd_app/config/theme/app_light_theme.dart';
import 'package:wknd_app/core/constant/app_string.dart';
import 'package:wknd_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:wknd_app/feature/refer/presentation/bloc/refer_bloc.dart';
import 'package:wknd_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<ReferBloc>(create: (context) => ReferBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        builder: (context, child) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          return child!;
        },
        debugShowCheckedModeBanner: false,
        title: AppString.appName,
        theme: AppLightTheme().themeData,
      ),
    );
  }
}
