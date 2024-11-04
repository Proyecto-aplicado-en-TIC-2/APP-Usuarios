import 'dart:ffi';

import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/Line.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Constants/my_flutter_app_icons.dart';
import 'package:appv2/Prioridad.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyState_1 extends StatelessWidget {
  const EmergencyState_1({super.key});

  @override
  Widget build(BuildContext context) {

    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Card(
      color: basilTheme?.primaryContainer,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estado de la emergencia',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),

                      Text(
                      'Solicitud enviada',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: basilTheme?.primary),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/alerta_card_1.png',
                          width: 40, // Ajusta la imagen según el ancho
                          height: 40, // Ajusta la imagen según la altura
                          fit: BoxFit.cover,
                          color: basilTheme?.primary,
                        ),
                        const Line(),
                        Image.asset(
                          'assets/alerta_card_2.png',
                          width: 40, // Ajusta la imagen según el ancho
                          height: 40, // Ajusta la imagen según la altura
                          fit: BoxFit.cover,
                          color: basilTheme?.onSurface,
                        ),
                        const Line(),
                        Image.asset(
                          'assets/alerta_card_3.png',
                          width: 40, // Ajusta la imagen según el ancho
                          height: 40, // Ajusta la imagen según la altura
                          fit: BoxFit.cover,
                          color: basilTheme?.onSurface,
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    const Center(
                      child: Button(
                        text: 'Cancelar solicitud',
                        width: 163,
                        onClick: ArgumentError.notNull,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



