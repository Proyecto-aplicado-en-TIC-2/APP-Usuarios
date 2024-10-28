import 'package:flutter/material.dart';
import 'aphome.dart';
import 'Incidentes.dart';
import '../MiPerfil.dart';
import 'InformePendiente.dart';

class InformesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('UPB Segura'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MiPerfilScreen()),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informes pendientes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            InformeCard(
              nombre: 'Jaider Joham Morales',
              ubicacion: 'Bloque 11',
              salon: '202',
              descripcion: 'Descripción',
              prioridad: 'Alta',
              prioridadColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => APHInformePendienteScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Ninguna',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Historial de Informes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            InformeCard(
              nombre: 'Jaider Joham Morales',
              ubicacion: 'Bloque 11',
              salon: '202',
              descripcion: 'Descripción',
              prioridad: 'Alta',
              prioridadColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => APHHomeScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            InformeCard(
              nombre: 'Jaider Joham Morales',
              ubicacion: 'Bloque 11',
              salon: '202',
              descripcion: 'Descripción',
              prioridad: 'Alta',
              prioridadColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => APHHomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => APHHomeScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => APHIncidentesScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformesScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Incidentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Informes',
          ),
        ],
      ),
    );
  }
}

class InformeCard extends StatelessWidget {
  final String nombre;
  final String ubicacion;
  final String salon;
  final String descripcion;
  final String prioridad;
  final Color prioridadColor;
  final VoidCallback onTap;

  const InformeCard({
    required this.nombre,
    required this.ubicacion,
    required this.salon,
    required this.descripcion,
    required this.prioridad,
    required this.prioridadColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
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
            const SizedBox(height: 5),
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
            const SizedBox(height: 5),
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
        ),
      ),
    );
  }
}

