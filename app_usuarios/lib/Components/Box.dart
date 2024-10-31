import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String topLabel;
  final String bottomHelperText;
  final TextEditingController controller;
  final TextInputType inputType;

  const Box({
    Key? key,
    required this.topLabel,
    required this.bottomHelperText,
    required this.controller,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' $topLabel',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: basilTheme?.onSurfaceVariant),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: inputType,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurfaceVariant),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: basilTheme?.surfaceContainer,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5), // Ajusta este valor para modificar la altura
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '   $bottomHelperText',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: basilTheme?.onSurfaceVariant),
        ),
      ],
    );
  }
}