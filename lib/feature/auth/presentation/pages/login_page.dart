import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wknd_app/config/router/route_path.dart';
import 'package:wknd_app/core/components/app_button.dart';
import 'package:wknd_app/core/components/app_image.dart';
import 'package:wknd_app/core/components/gap.dart';
import 'package:wknd_app/core/constant/app_string.dart';
import 'package:wknd_app/core/extensions/e_context_extensions.dart';
import 'package:wknd_app/core/mixin/validator.dart';
import 'package:wknd_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:wknd_app/gen/assets.gen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Validator {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: AppString.dontHaveAccount,
            style: context.titleLarge?.copyWith(fontSize: 14.0, color: context.onSecondary),
            children: [
              TextSpan(
                text: AppString.signUp,
                style: context.titleLarge?.copyWith(fontSize: 14.0),
                recognizer: TapGestureRecognizer()..onTap = () {
                  debugPrint('_LoginPageState.build: ');
                    context.push(RoutePath.signUp);
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(100.0),
                AppImage.assets(assetName: Assets.png.appLogo.path, width: 100.0, height: 100.0),
                const Gap(40.0),
                Text(AppString.welcomeToWKNDApp, style: context.displayLarge),
                const Gap(20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  validator: validateEmail,
                  decoration: const InputDecoration(
                    hintText: AppString.email,
                  ),
                ),
                const Gap(10.0),
                TextFormField(
                  obscureText: _obscureText,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  validator: validatePassword,
                  decoration:  InputDecoration(
                    hintText: AppString.password,
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: () {}, child: Text(AppString.forgotPassword)),
                ),
                const Gap(20.0),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is SignInSuccess) {
                      context.go(RoutePath.tabs);
                    } else if (state is SignInFailure) {
                      context.showSnackBar(message: state.message);
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      isProcessing: state is AuthLoading,
                      height: 50.0,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<AuthBloc>().add(SignIn(email: emailController.text, password: passwordController.text));
                        }
                      },
                      child: Text(AppString.signIn),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
