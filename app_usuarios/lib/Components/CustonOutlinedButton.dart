import 'package:flutter/material.dart';

import '../Constants/AppColors.dart';

class CustonOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width; // Ancho opcional

  const CustonOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Center(
      child: SizedBox(
        width: width, // Aplica el ancho
        height: 40, // Aplica la altura
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: basilTheme!.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0)
          ),
          child: Text(
              text,
              style: TextStyle(color: basilTheme?.primary)
          ),
        ),
      ),
    );
  }
}

