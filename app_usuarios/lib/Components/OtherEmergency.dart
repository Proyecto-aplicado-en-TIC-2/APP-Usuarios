import 'package:flutter/material.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/TipoEmergencia.dart';

class OtherEmergency extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final String text;
  final VoidCallback onTap;

  const OtherEmergency({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();

    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: color,
        elevation: 3, // Elevación light/3 de Material Design 3
        shadowColor: basilTheme!.surfaceContainer, // Color de la sombra
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          splashColor: basilTheme.surfaceContainer,
          onTap: onTap,
          child: SizedBox(
            width: width,
            height: height,
            child: Center( // Centra el contenido en ambas direcciones
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
