import 'package:appv2/Components/CallCentral.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/APH/CustonBottomNavigationBar.dart';
import 'package:appv2/Components/EmergencyCallbox.dart';
import 'package:appv2/Components/UserHello.dart';
import 'package:appv2/Constants/constants.dart';
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
import 'package:http/http.dart' as http;

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

  Future<void> _loadIncidents() async {
    try {
      final url = await APIConstants.getAllReportsEndpoint();
      print("Fetching reports from URL: $url");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token');
      if (token == null) {
        throw Exception("Access token not found in SharedPreferences.");
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print("Response body: ${response.body}");
        List<dynamic> data = json.decode(response.body);

        setState(() {
          incidentes = data.isNotEmpty
              ? data.map((item) => item as Map<String, dynamic>).toList()
              : [];
        });
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load reports: $e');
      setState(() {
        incidentes = [];
      });
    }
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
          children: [
            const UserHello(),
            const SizedBox(height: 30),
            Text(
              'Incidencias asignadas',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: incidentes.isEmpty
                  ? const Center(child: Text('No tiene incidencias asignadas'))
                  : ListView.builder(
                itemCount: incidentes.length,
                itemBuilder: (context, index) {
                  final report = incidentes[index];
                  return InformeCard(
                    nombre: "${report['reporter']['names']} ${report['reporter']['lastNames']}",
                    ubicacion: report['location']['block'],
                    salon: report['location']['classroom'].toString(),
                    descripcion: report['location']['pointOfReference'] ?? 'Sin descripción',
                    prioridad: report['priority'],
                    prioridadColor: report['priority'] == 'Alta' ? Colors.red : Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => APHPrioridadAltaScreen(incidentData: report),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Llamada de emergencia',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            const CallCentral(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WebSocketService.newIncidentNotifier.removeListener(_loadIncidents);
    super.dispose();
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
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: basilTheme?.primaryContainer,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: basilTheme?.onSurface),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Ubicación: $ubicacion   Salón: $salon',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: basilTheme?.onSurface),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          descripcion,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: basilTheme?.onSurface),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            prioridad,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: basilTheme?.onSurface),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: basilTheme?.onSurface,
                  size: 18,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10), // Espacio entre informes
        ],
      ),
    );
  }
}

