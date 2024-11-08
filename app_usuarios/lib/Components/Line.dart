import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  const Line({super.key,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 4, height: 2, color: Colors.black), // Punto
        SizedBox(width: 6), // Espacio
        Container(width: 8, height: 2, color: Colors.black), // Línea
        SizedBox(width: 4),
        Container(width: 8, height: 2, color: Colors.black), // Línea
        SizedBox(width: 6),
        Container(width: 4, height: 2, color: Colors.black), // Punto
      ],
    );
  }
}

