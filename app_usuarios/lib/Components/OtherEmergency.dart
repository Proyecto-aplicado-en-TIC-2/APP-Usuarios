import 'package:flutter/material.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/TipoEmergencia.dart';

class OtherEmergency extends StatelessWidget {
  final double width;
  final double height;

  const OtherEmergency({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();

    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: basilTheme!.secondary,
        elevation: 3, // Elevación light/3 de Material Design 3
        shadowColor: basilTheme.surfaceContainer, // Color de la sombra
        child: InkWell(
          splashColor: basilTheme.surfaceContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TiposEmergenciaScreen()),
            );
          },
          child: SizedBox(
            width: width,
            height: height,
            child: Center( // Centra el contenido en ambas direcciones
              child: Text(
                'Otro tipo de emergencias',
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
