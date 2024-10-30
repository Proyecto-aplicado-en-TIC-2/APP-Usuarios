import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final BasilTheme? basilTheme;
  final double? width; // Ancho opcional

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.basilTheme,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Aplica el ancho si está especificado
      height: 40, // Aplica la altura si está especificada
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: basilTheme!.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: basilTheme?.primary),
        ),
      ),
    );
  }
}