import 'dart:ffi';

import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CallButton.dart';
import 'package:appv2/Components/Line.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Constants/my_flutter_app_icons.dart';
import 'package:appv2/Prioridad.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyState_3 extends StatefulWidget {
  const EmergencyState_3({Key? key}) : super(key: key);

  @override
  _EmergencyState_3 createState() => _EmergencyState_3();
}

class _EmergencyState_3 extends State<EmergencyState_3> {
  String? APH_name;
  String? APH_phone;
  String? APH_time;
  bool isLoading = true; // Variable de carga

  @override
  void initState() {
    super.initState();
    _APH_assing();
  }

  Future<void> _APH_assing() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      APH_name = prefs.getString('APH_name') ?? 'Nombre no disponible';
      APH_phone = prefs.getString('APH_phone') ?? 'Teléfono no disponible';
      APH_time = prefs.getString('APH_time') ?? '0';
      isLoading = false; // Fin de la carga
    });
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator()); // Indicador de carga
    }

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
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                    Text(
                      'APH en camino',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: basilTheme?.primary),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/alerta_card_1.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          color: basilTheme?.onSurface,
                        ),
                        const Line(),
                        Image.asset(
                          'assets/alerta_card_2.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          color: basilTheme?.onSurface,
                        ),
                        const Line(),
                        Image.asset(
                          'assets/alerta_card_3.png',
                          width: 40,
                          height: 40,
                          color: basilTheme?.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'APH Asignado',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                    Text(
                      APH_name ?? 'Nombre no disponible',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Tiempo estimado de llegada',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                    Text(
                      '${APH_time ?? '0'} minutos',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: CallButton(
                        phone: APH_phone ?? 'Teléfono no disponible',
                      ),
                    ),
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