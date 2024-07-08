import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wknd_app/config/router/route_path.dart';
import 'package:wknd_app/core/components/app_button.dart';
import 'package:wknd_app/core/components/app_image.dart';
import 'package:wknd_app/core/components/gap.dart';
import 'package:wknd_app/core/constant/app_string.dart';
import 'package:wknd_app/core/extensions/e_context_extensions.dart';
import 'package:wknd_app/gen/assets.gen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: AppString.dontHaveAccount,
            style: context.titleLarge?.copyWith(fontSize: 14.0, color: context.onSecondary),
            children: [
              TextSpan(
                text: AppString.signUp,
                style: context.titleLarge?.copyWith(fontSize: 14.0),
                recognizer: TapGestureRecognizer()..onTap = () => context.go(RoutePath.signUp),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Gap(100.0),
              AppImage.assets(assetName: Assets.png.appLogo.path, width: 100.0, height: 100.0),
              const Gap(40.0),
              Text(AppString.welcomeToWKNDApp, style: context.displayLarge),
              const Gap(20.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: AppString.email,
                ),
              ),
              const Gap(10.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: AppString.password,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: Text(AppString.forgotPassword)),
              ),
              const Gap(20.0),
              AppButton(
                height: 50.0,
                onPressed: () => context.go(RoutePath.tabs),
                child: Text(AppString.signIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
