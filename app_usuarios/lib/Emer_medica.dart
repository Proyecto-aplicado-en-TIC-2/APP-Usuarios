import 'package:flutter/material.dart';

class EmerMedica extends StatelessWidget {
  const EmerMedica({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergencia médica'),
      ),

      body: Padding( // Agregar padding para el espaciado
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: Center(
                child:Image.asset('assets/images/first-aid-kit.png', width: 190, height: 190)
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nombre de la persona afectada',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Ubicación exacta',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Descripción de la emergencia',
              ),
            ),
          ],
        ),
      ),
    );
  }
}