import 'package:appv2/MiPerfil.dart';
import 'package:flutter/material.dart';
import 'OtrostiposEmergencias.dart';


class TiposEmergenciaScreen extends StatelessWidget {
  const TiposEmergenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: const Text('UPB Segura'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => const MiPerfilScreen(), 
                ),
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
              'Otros tipos de emergencias',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            EmergencyOptionCard(
              title: 'Incendio',
              onTap: () {    
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetalleEmergenciaScreen(), 
                      ),
                    );          
              },
            ),
            const SizedBox(height: 10),
            EmergencyOptionCard(
              title: 'Fugas de agua',
              onTap: () {              
              },
            ),
            const SizedBox(height: 10),
            EmergencyOptionCard(
              title: 'Actividad sospechosa',
              onTap: () {
              },
            ),
            const SizedBox(height: 10),
            EmergencyOptionCard(
              title: 'Otros',
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyOptionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const EmergencyOptionCard({super.key, 
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 202, 202, 202).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
