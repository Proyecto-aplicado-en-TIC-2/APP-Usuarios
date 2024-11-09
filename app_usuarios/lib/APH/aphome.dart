import 'package:appv2/Components/CallCentral.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/APH/CustonBottomNavigationBar.dart';
import 'package:appv2/Components/EmergencyCallbox.dart';
import 'package:appv2/Components/UserHello.dart';
import 'package:appv2/websocket_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Constants/AppColors.dart';
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

  @override
  void initState() {
    super.initState();
    _loadIncidents();

    // Escuchar cambios en el ValueNotifier del Singleton
    WebSocketService.newIncidentNotifier.addListener(() {
      _loadIncidents();
    });
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
          final incidentMap = jsonDecode(incidentData);

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
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
      backgroundColor: basilTheme?.surface,
      body: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            const UserHello(),
            const SizedBox(height: 30),
            Text(
              'Incidencias asignadas',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: incidentes.length,
                itemBuilder: (context, index) {
                  final incident = incidentes[index];
                  String prioridad = incident['Priorty'] ?? 'Alta';
                  Color prioridadColor;
                  // Determina el color de la prioridad
                  switch (prioridad.toLowerCase()) {
                    case 'Media':
                      prioridadColor = Colors.orangeAccent;
                      break;
                    case 'Baja':
                      prioridadColor = Colors.green;
                      break;
                    default:
                      prioridadColor = Colors.red;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Llamada de emergencia',
              style:  Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            const CallCentral()
          ],
        ),
      ),
    );
  }
}

