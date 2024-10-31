import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Components/EmergencyCard.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'MiPerfil.dart';
import 'UbicacionAltaPrioridad.dart';
import 'UbicacionMediaPrioridad.dart';

class PrioridadScreen extends StatelessWidget {
  const PrioridadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
      backgroundColor: basilTheme?.surface,
      appBar: CustonAppbar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5), // Padding de 5 a los lados
              child: Text(
                'Selecciona el tipo de emergencia',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: basilTheme?.onSurface),
              ),
            ),
            const SizedBox(height: 20),
            EmergencyCard(
              color: basilTheme!.primary,
              title: 'Alta prioridad',
              description:
              'Requiere intervención inmediata. Ejemplos: pérdida de conciencia, dificultad para respirar, sangrado abundante.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UbicacionMediaprioridadScreen(),
                  ),
                );
              },
              textColor: const Color(0xffffffff),
            ),
            const SizedBox(height: 10),
            EmergencyCard(
              color: basilTheme.primaryContainer,
              title: 'Media prioridad',
              description:
              'Situaciones serias pero no críticas. Ejemplos: fracturas, heridas profundas, dolor intenso persistente.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UbicacionMediaprioridadScreen(),
                  ),
                );
              },
              textColor: basilTheme.onSurface,
            ),
            const SizedBox(height: 10),
            EmergencyCard(
              color: basilTheme.primaryContainer,
              title: 'Baja prioridad',
              description:
              'Emergencias menores que no requieren atención inmediata. Ejemplos: cortes leves, mareos, molestias menores.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UbicacionMediaprioridadScreen(),
                  ),
                );
              },
              textColor: basilTheme.onSurface,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5), // Padding de 5 a los lados
              child: Text(
                'Importante',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: basilTheme?.onSurface),
              ),
            ),
            const SizedBox(height: 10),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
              child:   Text(
                'Durante este proceso, tu dispositivo enviará tu ubicación en tiempo real para facilitar la llegada del personal de APH y brindarte asistencia lo más rápido posible.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: basilTheme?.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
