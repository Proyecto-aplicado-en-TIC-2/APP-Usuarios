
import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmergencyReportCards extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    builder: (context, constraints) {
      // Calcula el ancho y altura basados en el tamaño del contenedor
      double cardHeight = constraints.maxWidth / 2; // Altura de las tarjetas cuadradas (1:1)
      double otherEmergencyHeight = cardHeight / 3 + cardHeight / 9; // 1/3 de la altura de las tarjetas
      return Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1, // Mantiene el ancho y alto iguales (cuadrado)
                  child: CardNeedHelp(
                    width: double.infinity, // Ignorado, ya que Expanded controla el tamaño
                    height: double.infinity,
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1, // Mantiene el ancho y alto iguales (cuadrado)
                  child: CardOtherNeedHelp(
                    width: double.infinity, // Ignorado, ya que Expanded controla el tamaño
                    height: double.infinity,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: otherEmergencyHeight, // Altura de 1/3 de las tarjetas superiores
            child: OtherEmergency(
              width: double.infinity,
              height: otherEmergencyHeight,
            ),
          ),
        ],
      );
    },),
    return builder;
  }