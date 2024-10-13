import 'package:flutter/material.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergencia de incendio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center( 
              child: Image.asset('assets/images/fuego.png', width: 190, height: 190),
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
            const SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFFB054B),
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