import 'dart:ffi';

import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/Line.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Constants/my_flutter_app_icons.dart';
import 'package:appv2/Prioridad.dart';
import 'package:flutter/material.dart';

class EmergencyState_2 extends StatelessWidget {
  const EmergencyState_2({super.key});


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
                      'Solicitud recibida',
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
                        Icon(
                            MyFlutterApp.concierge_bell,
                            size: 35,
                            color: basilTheme?.onSurface
                        ),
                        const Line(),
                        Icon(
                          MyFlutterApp.apartment,
                          size: 35,
                          color: basilTheme?.primary,
                        ),
                        const Line(),
                        Icon(
                          MyFlutterApp.directions_bike,
                          size: 35,
                          color: basilTheme?.onSurface,
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'APH Asignado',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                    Text(
                      'Nombre del aph',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Tiempo estimado de llegada',
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                    Text(
                      '12 minutos',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                    SizedBox(height: 10,),
                    const Button(
                      text: 'Llamar al APH',
                      width: 139,
                      onClick: ArgumentError.notNull,
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



