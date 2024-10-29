import 'package:appv2/websocket_service.dart';
import 'package:flutter/material.dart';
import 'AtenderEmergency.dart';
import 'Incidentes.dart';
import 'Informes.dart';
import '../MiPerfil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class APHHomeScreen extends StatefulWidget {
  @override
  _APHHomeScreenState createState() => _APHHomeScreenState();
}

class _APHHomeScreenState extends State<APHHomeScreen> {
  List<Map<String, dynamic>> incidentes = [];
  String greetingMessage = '';
  String userName = 'Usuario';
  String userRole = 'Usuario';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadIncidents();

    // Escuchar cambios en el ValueNotifier del Singleton
    WebSocketService.newIncidentNotifier.addListener(() {
      _loadIncidents();
    });
  }

  // Método para cargar los datos de usuario desde SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? names = prefs.getString('names') ?? 'Usuario';
    String? lastNames = prefs.getString('lastNames') ?? '';
    String? role = prefs.getString('user_role') ?? 'Usuario';

    // Agregar logs de depuración para verificar los valores recuperados
    print('Recuperado de SharedPreferences: names=$names, lastNames=$lastNames, role=$role');

    setState(() {
      userName = '$names $lastNames';
      userRole = role;
      greetingMessage = _getGreetingMessage();
    });
  }

  // Método para obtener el mensaje de saludo según la hora del día
  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buenos días';
    } else if (hour < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  // Método para cargar incidentes desde SharedPreferences
  Future<void> _loadIncidents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    List<Map<String, dynamic>> loadedIncidents = [];
    for (String key in keys) {
      final String? incidentData = prefs.getString(key);

      if (incidentData != null) {
        try {
          // Intenta decodificar la cadena como JSON
          final incidentMap = jsonDecode(incidentData);

          // Verifica si es un mapa que contiene los campos esperados
          if (incidentMap is Map<String, dynamic> && incidentMap['message'] != null && incidentMap['Lugar'] != null) {
            loadedIncidents.add(incidentMap);
          }
        } catch (e) {
          print('Error al decodificar JSON para la clave $key: $e');
        }
      }
    }

    setState(() {
      incidentes = loadedIncidents;
    });
  }

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
            Text(
              greetingMessage,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              userName,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              userRole,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Incidencias asignadas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: incidentes.length,
                itemBuilder: (context, index) {
                  final incident = incidentes[index];
                  return IncidenciaCard(
                    nombre: incident['message'] ?? 'Incidente',
                    ubicacion: incident['Lugar']['block'] ?? '',
                    salon: incident['Lugar']['classroom'].toString(),
                    descripcion: incident['Lugar']['pointOfReference'] ?? '',
                    prioridad: 'Alta',
                    prioridadColor: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => APHPrioridadAltaScreen(incidentData: incident),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Llamada de emergencia',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Llamar a la central',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.phone, color: Colors.white),
                      label: const Text('Llamar', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

class IncidenciaCard extends StatelessWidget {
  final String nombre;
  final String ubicacion;
  final String salon;
  final String descripcion;
  final String prioridad;
  final Color prioridadColor;
  final VoidCallback onTap;

  IncidenciaCard({
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
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.pink[50],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Ubicación: $ubicacion  Salón: $salon',
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      descripcion,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: prioridadColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  prioridad,
                  style: TextStyle(fontWeight: FontWeight.bold, color: prioridadColor),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_ios, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}