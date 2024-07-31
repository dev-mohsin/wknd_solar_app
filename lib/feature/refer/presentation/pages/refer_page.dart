import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wknd_app/core/components/app_button.dart';
import 'package:wknd_app/core/components/app_image_picker.dart';
import 'package:wknd_app/core/components/gap.dart';
import 'package:wknd_app/core/constant/app_string.dart';
import 'package:wknd_app/core/extensions/datetime_extension.dart';
import 'package:wknd_app/core/extensions/e_context_extensions.dart';

class ReferPage extends StatefulWidget {
  const ReferPage({super.key});

  @override
  State<ReferPage> createState() => _ReferPageState();
}

class _ReferPageState extends State<ReferPage> {
  String? country;
  final List<XFile> files = <XFile>[];
  String _selectedValue = AppString.yes;
  DateTime? selectedDate;
  DateTime? selectedTime;

  void _camera() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        files.add(file);
      });
    }
  }

  void _gallery() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        files.add(file);
      });
    }
  }

  void _pickedPdf() async {
    debugPrint('_ReferPageState._pickedPdf: ');
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        files.add(XFile(file.path));
      });
    } else {
      // User canceled the picker
    }
  }

  void _showPicker() {
    context.showBottomSheet(
      child: AppImagePicker(
        galleryOnTap: () {
          _gallery();
          context.pop();
        },
        pdfOnTap: () {
          debugPrint('_ReferPageState._showPicker: ');
          _pickedPdf();
          context.pop();
        },
        cameraOnTap: () {
          _camera();
          context.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(10.0),
              Center(child: Text(AppString.bookASolarConsultation, style: context.displayLarge?.copyWith(fontSize: 24.0))),
              const Gap(10.0),
              Center(child: Text(AppString.takeFirstStep, style: context.labelLarge?.copyWith(fontSize: 14.0))),
              const Gap(10.0),
              TextFormField(decoration: InputDecoration(hintText: AppString.theirName)),
              const Gap(10.0),
              TextFormField(decoration: InputDecoration(hintText: AppString.theirEmail)),
              const Gap(10.0),
              TextFormField(decoration: InputDecoration(hintText: AppString.theirPhoneNumber)),
              const Gap(10.0),
              Text(AppString.theirAddress, style: context.labelLarge?.copyWith(fontSize: 14.0)),
              Text(AppString.country),
              const Gap(10.0),
              InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) => setState(() => this.country = country.displayNameNoCountryCode),
                    moveAlongWithKeyboard: false,
                    countryListTheme: CountryListThemeData(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                      inputDecoration: InputDecoration(hintText: AppString.search, prefixIcon: const Icon(Icons.search)),
                    ),
                  );
                },
                child: Container(
                  height: 46.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: context.primary),
                  ),
                  child: Center(child: Text(country != null ? country ?? '' : AppString.selectCountry)),
                ),
              ),
              const Gap(10.0),
              TextFormField(decoration: InputDecoration(hintText: AppString.addressLine1)),
              const Gap(10.0),
              TextFormField(decoration: InputDecoration(hintText: AppString.addressLine2)),
              const Gap(10.0),
              Row(
                children: [
                  Expanded(child: TextFormField(decoration: InputDecoration(hintText: AppString.city))),
                  const Gap(10.0),
                  Expanded(child: TextFormField(decoration: InputDecoration(hintText: AppString.state))),
                  const Gap(10.0),
                  Expanded(child: TextFormField(decoration: InputDecoration(hintText: AppString.zipCode))),
                ],
              ),
              const Gap(10.0),
              Text(AppString.utilityBill, style: context.labelLarge?.copyWith(fontSize: 14.0)),
              const Gap(10.0),
              DottedBorder(
                color: context.primary,
                strokeWidth: 1,
                child: InkWell(
                  onTap: _showPicker,
                  child: SizedBox(
                    height: 100.0,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.cloud_upload, color: context.primary),
                        Text(AppString.addAFile, style: context.labelLarge?.copyWith(fontSize: 14.0)),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(10.0),
              Wrap(
                spacing: 10.0,
                children: files.map((file) {
                  return Stack(
                    children: [
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(border: Border.all(color: context.primary), borderRadius: BorderRadius.circular(8.0)),
                        child: ClipRRect(borderRadius: BorderRadius.circular(8.0), child: Image.file(File(file.path), fit: BoxFit.cover)),
                      ),
                      Positioned(
                        top: 6.0,
                        right: 6.0,
                        child: CircleAvatar(
                          radius: 10.0,
                          child: InkWell(
                            onTap: () => setState(() => files.remove(file)),
                            child: Icon(Icons.close, size: 16.0, color: context.primary),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const Gap(10.0),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(hintText: AppString.notes, contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0)),
              ),
              const Gap(10.0),
              Text(AppString.areTheyTheHomeOwner, style: context.labelLarge?.copyWith(fontSize: 14.0)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: AppString.yes,
                      groupValue: _selectedValue,
                      onChanged: (value) => setState(() => _selectedValue = value as String),
                      title: Text(AppString.yes),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: AppString.no,
                      groupValue: _selectedValue,
                      onChanged: (value) => setState(() => _selectedValue = value as String),
                      title: Text(AppString.no),
                    ),
                  ),
                ],
              ),
              const Gap(10.0),
              TextFormField(
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enableInteractiveSelection: false,
                controller: TextEditingController(text: selectedDate != null ? selectedDate?.format(format: 'yMd') : ''),
                decoration: InputDecoration(
                  hintText: AppString.dateOfConsultation,
                  suffixIcon: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                      ).then((value) => setState(() => selectedDate = value));
                    },
                    child: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
              const Gap(10.0),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: selectedTime != null ? selectedTime?.time() : ''),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  hintText: AppString.timeOfConsultation,
                  suffixIcon: InkWell(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then(
                        (value) => setState(
                            () => selectedTime = DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day, value!.hour, value.minute)),
                      );
                    },
                    child: const Icon(Icons.access_time),
                  ),
                ),
              ),
              const Gap(10.0),
              Text(AppString.yourName, style: context.labelLarge?.copyWith(fontSize: 14.0)),
              const Gap(10.0),
              Row(
                children: [
                  Expanded(child: TextFormField(decoration: InputDecoration(hintText: AppString.firstName))),
                  const Gap(10.0),
                  Expanded(child: TextFormField(decoration: InputDecoration(hintText: AppString.lastName))),
                ],
              ),
              const Gap(10.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(hintText: AppString.phoneNumber),
              ),
              const Gap(40.0),
              AppButton(
                height: 46.0,
                child: Text(AppString.submit),
              ),
              const Gap(20.0),
            ],
          ),
        ),
      ),
    );
  }
}
