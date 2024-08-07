import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wknd_app/config/router/route_path.dart';
import 'package:wknd_app/feature/auth/presentation/pages/login_page.dart';
import 'package:wknd_app/feature/auth/presentation/pages/signup_page.dart';
import 'package:wknd_app/feature/tabs/presentation/pages/tabs_page.dart';

final GoRouter router = GoRouter(
  redirect: (context, state) async {
    final bool loggedIn = await FirebaseAuth.instance.currentUser != null;
    final loggingIn = state.fullPath == RoutePath.login;
    final signingUp = state.fullPath == RoutePath.signUp;

    if (!loggedIn && !loggingIn && !signingUp) {
      return RoutePath.login;
    } else if (loggedIn && (loggingIn || signingUp)) {
      return RoutePath.tabs;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CupertinoPage(key: state.pageKey, child: const TabsPage()),
    ),
    GoRoute(
      path: RoutePath.signUp,
      pageBuilder: (context, state) => CupertinoPage(key: state.pageKey, child: const SignupPage()),
    ),
    GoRoute(
      path: RoutePath.login,
      pageBuilder: (context, state) => CupertinoPage(key: state.pageKey, child: const LoginPage()),
    ),
    GoRoute(
      path: RoutePath.tabs,
      pageBuilder: (context, state) => CupertinoPage(key: state.pageKey, child: const TabsPage()),
    ),
  ],
);

