import 'package:flutter/material.dart';
import 'package:wknd_app/config/router/app_router.dart';
import 'package:wknd_app/config/theme/app_light_theme.dart';
import 'package:wknd_app/core/constant/app_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}
