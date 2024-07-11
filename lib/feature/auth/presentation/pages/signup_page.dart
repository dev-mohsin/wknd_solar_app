import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wknd_app/config/router/route_path.dart';
import 'package:wknd_app/core/components/app_button.dart';
import 'package:wknd_app/core/components/app_check_box.dart';
import 'package:wknd_app/core/components/app_image.dart';
import 'package:wknd_app/core/components/gap.dart';
import 'package:wknd_app/core/constant/app_string.dart';
import 'package:wknd_app/core/extensions/e_context_extensions.dart';
import 'package:wknd_app/core/mixin/validator.dart';
import 'package:wknd_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:wknd_app/feature/auth/presentation/bloc/check_box_cubit.dart';
import 'package:wknd_app/gen/assets.gen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with Validator {
  final List<String> items = [AppString.referring, AppString.selling, AppString.buying];
  final List<String> hearingItems = ['I was referred', 'An ads', 'Other'];
  final CheckBoxCubit checkBoxCubit = CheckBoxCubit();
  bool val = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final data = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'password': '',
    'phoneNumber': '',
    'services': '',
    'howMuch': '',
    'howDid': '',
    'refFirstName': '',
    'refLastName': '',
    'message': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(60.0),
                  Center(child: AppImage.assets(assetName: Assets.png.appLogo.path, width: 100.0, height: 100.0)),
                  const Gap(20.0),
                  Center(
                    child: Text(
                      AppString.letsWorkTogether,
                      style: context.displayLarge?.copyWith(fontSize: 24.0),
                    ),
                  ),
                  const Gap(20.0),
                  TextFormField(
                    validator: validateFirstName,
                    onSaved: (value) => data['firstName'] = value!,
                    decoration: const InputDecoration(
                      hintText: AppString.firstName,
                    ),
                  ),
                  const Gap(10.0),
                  TextFormField(
                    validator: validateLastName,
                    onSaved: (value) => data['lastName'] = value!,
                    decoration: const InputDecoration(
                      hintText: AppString.lastName,
                    ),
                  ),
                  const Gap(10.0),
                  TextFormField(
                    validator: validateEmail,
                    onSaved: (value) => data['email'] = value!,
                    decoration: const InputDecoration(
                      hintText: AppString.email,
                    ),
                  ),
                  const Gap(10.0),
                  TextFormField(
                    validator: validatePassword,
                    onSaved: (value) => data['password'] = value!,
                    decoration: const InputDecoration(
                      hintText: AppString.password,
                    ),
                  ),
                  const Gap(10.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: AppString.phoneNumber,
                    ),
                  ),
                  const Gap(10.0),
                  Text(
                    AppString.whatServicesAreYouInInterestedIn,
                    style: context.labelLarge?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  BlocBuilder<CheckBoxCubit, List<bool>>(
                    bloc: checkBoxCubit,
                    builder: (context, state) {
                      return Row(
                        children: List.generate(
                          items.length,
                              (index) {
                            return AppCheckBox(
                              label: items[index],
                              onChanged: (value) => checkBoxCubit.onChanged(value!, index),
                              value: state[index],
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const Gap(10.0),
                  TextFormField(
                    validator: validateFirstName,
                    onSaved: (value) => data['howMuch'] = value!,
                    decoration: const InputDecoration(
                      hintText: AppString.howMuchDoYouWantToMake,
                    ),
                  ),
                  const Gap(10.0),
                  Text(
                    AppString.howDidYouHearAboutUs,
                    style: context.labelLarge?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  const Gap(4.0),
                  DropdownMenu<String>(
                    width: context.width * 0.91,
                    initialSelection: AppString.referring,
                    onSelected: (color) {},
                    dropdownMenuEntries: hearingItems.map<DropdownMenuEntry<String>>((label) {
                      return DropdownMenuEntry<String>(
                        value: label,
                        label: label,
                      );
                    }).toList(),
                  ),
                  const Gap(10.0),
                  Text(
                    AppString.whoReferredYou,
                    style: context.labelLarge?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  const Gap(4.0),
                  TextFormField(
                    validator: validateFirstName,
                    onSaved: (value) => data['whoReferred'] = value!,
                    decoration: const InputDecoration(
                      hintText: AppString.firstName,
                    ),
                  ),
                  const Gap(10.0),
                  TextFormField(
                    validator: validateLastName,
                    onSaved: (value) => data['refFirstName'] = value!,
                    decoration: const InputDecoration(
                      hintText: AppString.lastName,
                    ),
                  ),
                  const Gap(10.0),
                  TextFormField(
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: AppString.message,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    ),
                  ),
                  const Gap(40.0),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return AppButton(
                        height: 50.0,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print(data);
                          }
                        },
                        child: const Text(AppString.signUp),
                      );
                    },
                  ),
                  const Gap(20.0),
                  RichText(
                    text: TextSpan(
                      text: AppString.haveAnAccount,
                      style: context.titleLarge?.copyWith(fontSize: 14.0, color: context.onSecondary),
                      children: [
                        TextSpan(
                          text: AppString.signIn,
                          style: context.titleLarge?.copyWith(fontSize: 14.0),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.go(RoutePath.login),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
