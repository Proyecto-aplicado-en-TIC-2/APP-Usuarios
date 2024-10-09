import 'package:flutter/material.dart';

class EmerMedica extends StatelessWidget {
  const EmerMedica({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergencia médica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center( 
              child: Image.asset('assets/images/first-aid-kit.png', width: 190, height: 190),
            ),
            SizedBox(height: 20),
            TextField( // Eliminar const del TextField
              decoration: InputDecoration(
                labelText: 'Ubicación exacta',
              ),
            ),
            SizedBox(height: 16),
            TextField( // Eliminar const del TextField
              decoration: InputDecoration(
                labelText: 'Nombre de la persona afectada',
              ),
            ),
            SizedBox(height: 16),
            TextField( // Eliminar const del TextField
              decoration: InputDecoration(
                labelText: 'Descripción de la emergencia',
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFA13F91),
                padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 25),
                textStyle: const TextStyle(fontSize: 20)
              ),
              onPressed: () {
              },
              child: const Text('Reportar emergencia'), 
            )
          ],
        ),
      ),
    );
  }
}