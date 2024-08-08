import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:uuid/uuid.dart';
import 'package:wknd_app/core/components/app_button.dart';
import 'package:wknd_app/core/components/app_image_picker.dart';
import 'package:wknd_app/core/components/gap.dart';
import 'package:wknd_app/core/constant/app_string.dart';
import 'package:wknd_app/core/extensions/datetime_extension.dart';
import 'package:wknd_app/core/extensions/e_context_extensions.dart';
import 'package:wknd_app/core/mixin/validator.dart';
import 'package:wknd_app/feature/refer/data/models/refer_model.dart';
import 'package:wknd_app/feature/refer/presentation/bloc/refer_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ReferPage extends StatefulWidget {
  const ReferPage({super.key});

  @override
  State<ReferPage> createState() => _ReferPageState();
}

class _ReferPageState extends State<ReferPage> with Validator {
  String? country;
  final List<XFile> files = <XFile>[];
  String _selectedValue = AppString.yes;
  DateTime? selectedDate;
  DateTime? selectedTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<double> uploadProgress = [];
  List<String> filePaths = [];
  String userId=FirebaseAuth.instance.currentUser?.uid?? 'default_user_id';

   @override
  void initState() {
    super.initState();
    context.read<ReferBloc>().add(FetchRefer(userId: userId));
  }
  

  // Define the base path in Firebase storage
  final String firebaseBasePath = 'uploads/';

  void _camera() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        files.add(file);
        uploadProgress.add(0); // Add initial progress
        filePaths.add(''); // Add initial file path
      });
    }
    await _uploadFileToFirebase(file!, files.length - 1);
  }

  void _pickedPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      XFile xfile = XFile(file.path);
      setState(() {
        files.add(xfile);
        uploadProgress.add(0); // Add initial progress
        filePaths.add('');
      });
      await _uploadFileToFirebase(xfile, files.length - 1);
    }
  }

  Future<void> _uploadFileToFirebase(XFile file, int index) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('$firebaseBasePath${file.name}');
      final uploadTask = storageRef.putFile(File(file.path));

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = (snapshot.bytesTransferred.toDouble() / snapshot.totalBytes.toDouble()) * 100;
        setState(() {
          uploadProgress[index] = progress;
        });
      });

      await uploadTask.whenComplete(() async {
        String downloadURL = await storageRef.getDownloadURL();
        setState(() {
          filePaths[index] = downloadURL;
        });
        print('Upload complete: ${file.name}, Download URL: $downloadURL');
      });
      debugPrint('_ReferPageState._uploadFileToFirebase: filpath: ${filePaths[index]}  length: ${filePaths}');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> _removeFile(int index) async {
    try {
      final fileName = files[index].name;
      final storageRef = FirebaseStorage.instance.ref().child('$firebaseBasePath$fileName');
      await storageRef.delete();
      setState(() {
        files.removeAt(index);
        uploadProgress.removeAt(index);
        filePaths.removeAt(index);
      });
      print('File removed: $fileName');
    } catch (e) {
      print('Error removing file: $e');
    }
  }

  void _showPicker() {
    context.showBottomSheet(
      child: AppImagePicker(
        galleryOnTap: () {
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

  final _referLIst = {
    'theirName': '',
    'theirEmail': '',
    'theirPhoneNumber': '',
    'addressLine1': '',
    'addressLine2': '',
    'city': '',
    'state': '',
    'zipCode': '',
    'notes': '',
    'dateOfConsultation': '',
    'timeOfConsultation': '',
    'firstName': '',
    'lastName': '',
    'phoneNumber': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(10.0),
                Center(child: Text(AppString.bookASolarConsultation, style: context.displayLarge?.copyWith(fontSize: 24.0))),
                const Gap(10.0),
                Center(child: Text(AppString.takeFirstStep, style: context.labelLarge?.copyWith(fontSize: 14.0))),
                const Gap(10.0),
                TextFormField(
                  decoration: InputDecoration(hintText: AppString.theirName),
                  validator: validateTheirName,
                  onSaved: (value) => _referLIst['theirName'] = value!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const Gap(10.0),
                TextFormField(
                  decoration: InputDecoration(hintText: AppString.theirEmail),
                  validator: validateTheirEmail,
                  onSaved: (value) => _referLIst['theirEmail'] = value!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const Gap(10.0),
                TextFormField(
                  decoration: InputDecoration(hintText: AppString.theirPhoneNumber),
                  validator: validateTheirPhoneNumber,
                  onSaved: (value) => _referLIst['theirPhoneNumber'] = value!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
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
                TextFormField(
                  onSaved: (value) => _referLIst['addressLine1'] = value!,
                  decoration: InputDecoration(hintText: AppString.addressLine1),
                  validator: validateAddressLine1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const Gap(10.0),
                TextFormField(
                  decoration: InputDecoration(hintText: AppString.addressLine2),
                  onSaved: (value) => _referLIst['addressLine2'] = value!,
                ),
                const Gap(10.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(hintText: AppString.city),
                        validator: validateCity,
                        onSaved: (value) => _referLIst['city'] = value!,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const Gap(10.0),
                    Expanded(
                      child: TextFormField(
                        onSaved: (value) => _referLIst['state'] = value!,
                        decoration: InputDecoration(hintText: AppString.state),
                        validator: validateState,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const Gap(10.0),
                    Expanded(
                      child: TextFormField(
                        onSaved: (value) => _referLIst['zipCode'] = value!,
                        decoration: InputDecoration(hintText: AppString.zipCode),
                        validator: validateZipCode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
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
                ListView.separated(
                  separatorBuilder: (context, index) => const Gap(10.0),
                  itemCount: files.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: context.primary.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      title: Text(files[index].name),
                      contentPadding: EdgeInsets.only(left: 16.0),
                      subtitle: Stack(
                        children: [
                          LinearProgressIndicator(
                            value: 1.0,
                            backgroundColor: context.primary.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(context.tertiary),
                          ),
                          LinearProgressIndicator(
                            value: uploadProgress[index] / 100,
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(context.primary),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(LineIcons.trash, color: context.error),
                        onPressed: () => _removeFile(index),
                      ),
                    );
                  },
                ),
                const Gap(10.0),
                TextFormField(
                  maxLines: 4,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validateNotes,
                  onSaved: (value) => _referLIst['notes'] = value!,
                  decoration: InputDecoration(
                    hintText: AppString.notes,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  ),
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
                  validator: validateDateOfConsultation,
                  readOnly: true,
                  onSaved: (value) => _referLIst['dateOfConsultation'] = value!,
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
                      child: const Icon(LineIcons.calendarAlt),
                    ),
                  ),
                ),
                const Gap(10.0),
                TextFormField(
                  onSaved: (value) => _referLIst['timeOfConsultation'] = value!,
                  validator: validateTimeOfConsultation,
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
                      child: const Icon(LineIcons.clock),
                    ),
                  ),
                ),
                const Gap(10.0),
                Text(AppString.yourName, style: context.labelLarge?.copyWith(fontSize: 14.0)),
                const Gap(10.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onSaved: (value) => _referLIst['firstName'] = value!,
                        decoration: InputDecoration(hintText: AppString.firstName),
                        validator: validateFirstName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    const Gap(10.0),
                    Expanded(
                      child: TextFormField(
                        onSaved: (value) => _referLIst['lastName'] = value!,
                        decoration: InputDecoration(hintText: AppString.lastName),
                        validator: validateLastName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ],
                ),
                const Gap(10.0),
                TextFormField(
                  onSaved: (value) => _referLIst['phoneNumber'] = value!,
                  validator: validatePhoneNumber,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(hintText: AppString.phoneNumber),
                ),
                const Gap(40.0),
                BlocConsumer<ReferBloc, ReferState>(
                  listener: (context, state) {
                    if (state is ReferCreatedSuccess) {
                      context.showSnackBar(message: state.message);
                    } else if (state is ReferFailure) {
                      context.showSnackBar(message: 'Refer Failure');
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      height: 46.0,
                      isProcessing: state is ReferLoading,
                      onPressed: () async {
                        String referralId = Uuid().v4();

                        // Clear previous debug logs
                        debugPrint('Starting form submission process');

                        // Check file upload
                        if (files.isEmpty) {
                          context.showSnackBar(message: 'Please Upload at least One File');
                          debugPrint('No files uploaded');
                          return;
                        }

                        // Check country selection
                        if (country?.isEmpty ?? true) {
                          context.showSnackBar(message: 'Please Choose the Country');
                          debugPrint('Country not selected');
                          return;
                        }
                        _formKey.currentState!.save();

                        debugPrint('_ReferPageState.build: if $_referLIst');
                        final refer = ReferModel(
                          theirName: _referLIst['theirName'] ?? '',
                          theirEmail: _referLIst['theirEmail'] ?? '',
                          theirPhone: _referLIst['theirPhoneNumber'] ?? '',
                          theirCountry: country ?? '',
                          theirAddress1: _referLIst['addressLine1'] ?? '',
                          theirAddress2: _referLIst['addressLine2'] ?? '',
                          theirCity: _referLIst['city'] ?? '',
                          theirState: _referLIst['state'] ?? '',
                          theirZipCode: _referLIst['zipCode'] ?? '',
                          theirUtilityBill: filePaths,
                          theirNotes: _referLIst['notes'] ?? '',
                          areTheyHomeOwner: _selectedValue == AppString.yes ? "true" : "false",
                          dateOfConsultation: selectedDate.toString(),
                          timeOfConsultation: selectedTime.toString(),
                          referredByFirstName: _referLIst['firstName'] ?? '',
                          referredByLastName: _referLIst['lastName'] ?? '',
                          referredByPhone: _referLIst['phoneNumber'] ?? '',
                          referralId: referralId,
                          status: 'Pending',
                          userId: userId,
                        );
                        try {
                          context.read<ReferBloc>().add(OnRefer(refer: refer));
                        } catch (e) {
                          // Handle potential errors here
                          context.showSnackBar(message: 'An error occurred: $e');
                        }
                      },
                      child: Text(AppString.submit),
                    );
                  },
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
