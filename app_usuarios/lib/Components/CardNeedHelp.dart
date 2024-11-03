import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Prioridad.dart';
import 'package:flutter/material.dart';

class CardNeedHelp extends StatelessWidget {
  final double width;
  final double height;

  const CardNeedHelp({
    Key? key,
    required this.width,
    required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();

    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: basilTheme!.primary,
        elevation: 3, // Elevación light/3 de Material Design 3
        shadowColor: basilTheme.surfaceContainer, // Color de la sombra
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(

          splashColor: basilTheme.surfaceContainer,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PrioridadScreen()),
            );
          },
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/TengoEmergencia.png',
                  width: 40, // Ajusta la imagen según el ancho
                  height: 40, // Ajusta la imagen según la altura
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  'Tengo una\n' 'emergencia médica',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}