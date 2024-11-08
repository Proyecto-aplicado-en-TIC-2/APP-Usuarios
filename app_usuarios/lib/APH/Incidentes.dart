import 'package:appv2/APH/CustonBottomNavigationBar.dart';
import 'package:appv2/Components/OtherEmergency.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Prioridad.dart';
import 'package:appv2/TipoEmergencia.dart';
import 'package:flutter/material.dart';
import 'aphome.dart';
import 'Informes.dart';
import 'IncidenciaMedica.dart';
import 'otrasincidencia.dart';
import '../MiPerfil.dart';

class APHIncidentesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reportar',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            OtherEmergency(width: 372,
                height: 64,
                color: basilTheme?.custom,
                text: 'Incidencia medica',
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrioridadScreen(type: 2)),
                );
              },
            ),
            const SizedBox(height: 10),
                OtherEmergency(width: 372,
                height: 64,
                color: basilTheme?.secondary,
                text: 'Otro tipo de incidencia',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TiposEmergenciaScreen()),
                    );
                  },
                ),
            const SizedBox(height: 30),
            const Text(
              'Historial de incidentes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            IncidenciaCard(
              nombre: 'Jaider Joham Morales',
              ubicacion: 'Bloque 11',
              salon: '202',
              descripcion: 'Descripción',
              prioridad: 'Alta',
              prioridadColor: Colors.red,
            ),
            const SizedBox(height: 10),
            IncidenciaCard(
              nombre: 'Otro tipo de incidencia',
              ubicacion: 'Bloque 11',
              salon: '202',
              descripcion: 'Descripción',
              prioridad: '',
              prioridadColor: Colors.transparent,
            ),
          ],
        ),
      ),

    );
  }
}

class IncidenciaCard extends StatelessWidget {
  final String nombre;
  final String ubicacion;
  final String salon;
  final String descripcion;
  final String prioridad;
  final Color prioridadColor;

  IncidenciaCard({
    required this.nombre,
    required this.ubicacion,
    required this.salon,
    required this.descripcion,
    required this.prioridad,
    required this.prioridadColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.pink[50],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Ubicación: $ubicacion  Salón: $salon',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              descripcion,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            if (prioridad.isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: prioridadColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  prioridad,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: prioridadColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


