import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onClick;
  final BasilTheme? basilTheme;

  const Button({
    Key? key,
    required this.text,
    required this.width,
    required this.onClick,
    required this.basilTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: 40,
        child: ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            backgroundColor: basilTheme?.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}