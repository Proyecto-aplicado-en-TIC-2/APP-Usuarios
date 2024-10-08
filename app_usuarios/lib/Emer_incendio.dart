import 'package:flutter/material.dart';

class EmerIncendio extends StatelessWidget {
  const EmerIncendio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergencia de incendio'),
      ),

      body: Padding( // Agregar padding para el espaciado
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: Center(
                child:Image.asset('assets/images/fuego.png', width: 190, height: 190)
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Ubicación exacta',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Magnitud del incendio',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: '¿Hay personas en riesgo?',
              ),
            ),
          ],
        ),
      ),
    );
  }
}