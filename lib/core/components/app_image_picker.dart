import 'package:flutter/material.dart';
import 'package:wknd_app/core/components/gap.dart';
import 'package:wknd_app/core/constant/app_string.dart';

class AppImagePicker extends StatelessWidget {
  final VoidCallback galleryOnTap;
  final VoidCallback cameraOnTap;

  const AppImagePicker({super.key, required this.cameraOnTap, required this.galleryOnTap});

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
