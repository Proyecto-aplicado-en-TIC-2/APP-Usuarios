import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String topLabel;
  final String bottomHelperText;
  final TextEditingController controller;
  final BasilTheme? basilTheme;

  const Box({
    Key? key,
    required this.topLabel,
    required this.bottomHelperText,
    required this.controller,
    required this.basilTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' ' + topLabel,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: basilTheme?.onSurfaceVariant),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurfaceVariant),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: basilTheme?.surfaceContainer,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '   ' + bottomHelperText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: basilTheme?.onSurfaceVariant),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}