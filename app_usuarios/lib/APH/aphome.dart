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
   _APHHomeScreenState  createState() =>  _APHHomeScreenState();
}

class _APHHomeScreenState extends State<APHHomeScreen> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> incidentes = [];
  bool isLoading = true; // Indica si está cargando
  late AnimationController _animationController;
  int _currentPageIndex = 0;
  String? onTheWayCaseId;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Hace que la animación respire

    _loadSelectedIncident();
    _loadIncidents();

    WebSocketService.newIncidentNotifier.addListener(() {
      _loadIncidents();
    });
  }

  Future<void> _loadSelectedIncident() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      onTheWayCaseId = prefs.getString('onTheWayCase');
    });
  }

  Future<void> _loadIncidents() async {
    setState(() {
      isLoading = true;
    });
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

        if (mounted) {
          setState(() {
            incidentes = data.isNotEmpty
                ? data.map((item) => item as Map<String, dynamic>).toList()
                : [];

            incidentes.sort((a, b) {
              if (a['id'] == onTheWayCaseId) return -1;
              if (b['id'] == onTheWayCaseId) return 1;

              const prioridadOrden = {'Alta': 1, 'Media': 2, 'Baja': 3};
              return (prioridadOrden[a['priority']] ?? 3).compareTo(prioridadOrden[b['priority']] ?? 3);
            });
          });
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load reports: $e');
      if (mounted) {
        setState(() {
          incidentes = [];
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    WebSocketService.newIncidentNotifier.removeListener(() {
      _loadIncidents();
    });
    _animationController.dispose();
    super.dispose();
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
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : incidentes.isEmpty
                  ? const Center(child: Text('No tiene incidencias asignadas'))
                  : PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: incidentes.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final report = incidentes[index];
                  final isSelected = report['id'] == onTheWayCaseId;
                  final color = isSelected ? basilTheme!.primary : basilTheme!.primaryContainer;
                  final textColor = isSelected ? Colors.white : basilTheme!.onSurface;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InformeCard(
                        nombre: "${report['reporter']['names']} ${report['reporter']['lastNames']}",
                        ubicacion: report['location']['block'],
                        salon: report['location']['classroom'].toString(),
                        descripcion: report['location']['pointOfReference'] ?? 'Sin descripción',
                        prioridad: report['priority'],
                        prioridadColor: color,
                        textColor: textColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => APHPrioridadAltaScreen(incidentData: report),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      ScaleTransition(
                        scale: Tween(begin: 1.0, end: 1.2).animate(_animationController),
                        child: Icon(
                          _currentPageIndex == incidentes.length - 1
                              ? Icons.arrow_drop_up_rounded
                              : Icons.arrow_drop_down_rounded,
                          color: basilTheme.onSurfaceVariant,
                          size: 38,
                        ),
                      ),
                    ],
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
}

class InformeCard extends StatelessWidget {
  final String nombre;
  final String ubicacion;
  final String salon;
  final String descripcion;
  final String prioridad;
  final Color prioridadColor;
  final Color textColor;
  final VoidCallback onTap;

  const InformeCard({
    required this.nombre,
    required this.ubicacion,
    required this.salon,
    required this.descripcion,
    required this.prioridad,
    required this.prioridadColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        color: prioridadColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Ubicación: $ubicacion   Salón: $salon',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        descripcion,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: textColor),
                        ),

                        child: Text(
                          prioridad,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: textColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

