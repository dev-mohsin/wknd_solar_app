import 'package:flutter/material.dart';
import 'package:wknd_app/core/components/gap.dart';
import 'package:wknd_app/core/constant/app_string.dart';

class AppImagePicker extends StatelessWidget {
  final VoidCallback galleryOnTap;
  final VoidCallback cameraOnTap;
  final VoidCallback pdfOnTap;

  const AppImagePicker({super.key, required this.cameraOnTap, required this.galleryOnTap, required this.pdfOnTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text(AppString.gallery),
            onTap: galleryOnTap,
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text(AppString.pdf),
            onTap: pdfOnTap,
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text(AppString.camera),
            onTap: cameraOnTap,
          ),
          const Gap(10.0),
        ],
      ),
    );
  }
}
