import 'package:appv2/Components/CardNeedHelp.dart';
import 'package:appv2/Components/CardOtherNeedHelp.dart';
import 'package:flutter/material.dart';


import 'OtherEmergency.dart';

class EmergencyLayout extends StatelessWidget {
  const EmergencyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
      },
    );
  }
}