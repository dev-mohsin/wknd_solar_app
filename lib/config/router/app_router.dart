import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wknd_app/feature/auth/presentation/pages/login_page.dart';
import 'package:wknd_app/feature/auth/presentation/pages/signup_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CupertinoPage(key: state.pageKey, child: const SignupPage()),
    ),
  ],
);
