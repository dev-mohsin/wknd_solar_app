import 'package:flutter/material.dart';

class AppCheckBox extends StatelessWidget {
  final String label;
  final void Function(bool?)? onChanged;
  final bool value;

  const AppCheckBox({super.key, required this.label, this.onChanged, this.value = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(label),
      ],
    );
  }
}
