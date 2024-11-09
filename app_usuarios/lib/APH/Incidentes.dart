import 'package:appv2/APH/CustonBottomNavigationBar.dart';
import 'package:appv2/APH/InformePendiente.dart';
import 'package:appv2/Components/OtherEmergency.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Constants/constants.dart';
import 'package:appv2/Prioridad.dart';
import 'package:appv2/TipoEmergencia.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'aphome.dart';
import 'Informes.dart';
import 'IncidenciaMedica.dart';
import 'otrasincidencia.dart';
import '../MiPerfil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APHIncidentesScreen extends StatelessWidget {

  Future<List<Map<String, dynamic>>> fetchReports() async {
    try {
      // Obtener la URL completa con el userID desde SharedPreferences
      final url = await APIConstants.getAllReportsEndpoint();
      print("Fetching reports from URL: $url");  // Verificar la URL

      // Obtener el token de SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token');
      if (token == null) {
        throw Exception("Access token not found in SharedPreferences.");
      }

      // Configurar los encabezados de la solicitud con el Bearer Token
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print("Response body: ${response.body}"); // Verificar el cuerpo de la respuesta
        List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          return data.map((item) => item as Map<String, dynamic>).toList();
        } else {
          print("Response is empty or not in the expected format.");
          return [];
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load reports: $e');
      return [];
    }
  }
  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              '  Reportar',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 20),
            OtherEmergency(width: 372,
                height: 64,
                color: basilTheme?.custom,
                text: 'Incidencia medica',
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrioridadScreen(type: 2)),
                );
              },
            ),
            const SizedBox(height: 10),
                OtherEmergency(width: 372,
                height: 64,
                color: basilTheme?.secondary,
                text: 'Otro tipo de incidencia',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TiposEmergenciaScreen()),
                    );
                  },
                ),
            const SizedBox(height: 30),
            Text(
              '  Informes pendientes',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchReports(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading reports'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No reports available'));
                  }
                  final reports = snapshot.data!;
                  return ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      return InformeCard(
                        nombre: "${report['reporter']['names']}${report['reporter']['lastNames']}",
                        ubicacion: report['location']['block'],
                        salon: report['location']['classroom'].toString(),
                        descripcion: report['location']['pointOfReference'] ?? 'Sin descripción',
                        prioridad: report['priority'],
                        prioridadColor: report['priority'] == 'Alta' ? Colors.red : Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => APHInformePendienteScreen(report: report),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

          ],
        ),
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
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                        style:  Theme.of(context).textTheme.labelMedium?.copyWith(color: basilTheme?.onSurface),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_sharp, // Tamaño del icono
              color: basilTheme?.onSurface,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}




