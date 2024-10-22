import 'package:flutter/material.dart';

class TipoEmergenciaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPB Segura'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // Envolvemos el cuerpo en un SingleChildScrollView
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecciona el tipo de emergencia',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            EmergencyCard(
              color: Colors.brown,
              title: 'Alta prioridad',
              description:
                  'Requiere intervención inmediata. Ejemplos: pérdida de conciencia, dificultad para respirar, sangrado abundante.',
              onTap: () {
              },
            ),
            const SizedBox(height: 10),
            EmergencyCard(
              color: Colors.pink[200]!,
              title: 'Media prioridad',
              description:
                  'Situaciones serias pero no críticas. Ejemplos: fracturas, heridas profundas, dolor intenso persistente.',
              onTap: () {
              },
            ),
            const SizedBox(height: 10),
            EmergencyCard(
              color: Colors.pink[100]!,
              title: 'Baja prioridad',
              description:
                  'Emergencias menores que no requieren atención inmediata. Ejemplos: cortes leves, mareos, molestias menores.',
              onTap: () {
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Importante',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Durante este proceso, tu dispositivo enviará tu ubicación en tiempo real para facilitar la llegada del personal de APH y brindarte asistencia lo más rápido posible.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  final VoidCallback onTap;

  EmergencyCard({
    required this.color,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Detectar toque
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}


