import 'package:flutter/material.dart';
import 'package:wknd_app/core/components/app_button.dart';
import 'package:wknd_app/core/components/app_check_box.dart';
import 'package:wknd_app/core/components/gap.dart';
import 'package:wknd_app/core/constant/app_string.dart';
import 'package:wknd_app/core/extensions/e_context_extensions.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final List<String> items = [AppString.referring, AppString.selling, AppString.buying];
  final List<String> hearingItems = ['I was referred', 'An ads', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20.0),
                Center(
                  child: Text(
                    AppString.letsWorkTogether,
                    style: context.displayLarge?.copyWith(fontSize: 24.0),
                  ),
                ),
                const Gap(10.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: AppString.firstName,
                  ),
                ),
                const Gap(10.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: AppString.lastName,
                  ),
                ),
                const Gap(10.0),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: AppString.email,
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
                Row(
                  children: List.generate(
                    items.length,
                    (index) => AppCheckBox(label: items[index], onChanged: (value) {}),
                  ),
                ),
                const Gap(10.0),
                TextFormField(
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
                  decoration: const InputDecoration(
                    hintText: AppString.firstName,
                  ),
                ),
                const Gap(10.0),
                TextFormField(
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
                AppButton(
                  height: 50.0,
                  onPressed: () {},
                  child: const Text(AppString.signUp),
                ),
                const Gap(20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
