import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double size;

  const Gap(this.size, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: size, width: size);
}
