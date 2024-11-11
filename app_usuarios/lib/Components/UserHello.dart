import 'dart:convert';

import 'package:appv2/APH/BrigadierEmergencyInfo.dart';
import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CallButton.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHello extends StatefulWidget {
  const UserHello({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<UserHello> {
  bool isActive = true;
  bool isBrigadeAccount = false;
  String greetingMessage = '';
  String userName = 'Usuario';
  String userRole = 'Usuario';


  String i_nombre = '';
  String i_ubicacion = '';
  String i_salon = '';
  String i_descripcion = '';
  String i_prioridad = '';
  bool isInCase = false;
  String aphPhone = '';


  @override
  void initState() {
    super.initState();
    _loadUserData();
    WebSocketService.newIncidentNotifier.addListener(() {
      _closeCase();
      _setEmergency();
    });
  }

  @override
  void dispose() {
    WebSocketService.newIncidentNotifier.removeListener(() {
      _closeCase();
      _setEmergency();
    });
    super.dispose();
  }

  Future<void> _closeCase() async {

    if (!mounted) return; // Asegúrate de que el widget esté en el árbol
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? Close_incident_broadcast = prefs.getBool('Close_incident_broadcast');
    if(Close_incident_broadcast == true){
      setState(() {
        isInCase = false;
        print('Close_incident_broadcast _closeCase $Close_incident_broadcast');
      });
    }
  }

  Future<void> _setEmergency() async {
    print('_setEmergency');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Obtiene el JSON almacenado como cadena
    bool? Close_incident_broadcast = prefs.getBool('Close_incident_broadcast');

    if(Close_incident_broadcast == true){
      print('Close_incident_broadcast _setEmergency_1 $Close_incident_broadcast');
      prefs.setBool('Close_incident_broadcast', false);
      prefs.setString('Brigadista_case', '');
    }
    String? data = prefs.getString('Brigadista_case');
    if (data != '' && data != null) {
      print('Close_incident_broadcast = false');
      // Convierte la cadena JSON en un objeto Map
      late Map<String, dynamic> jsonData = jsonDecode(data);
      setState(() {
        jsonData = jsonDecode(data);
        // Accede a los valores y convierte 'classroom' a String
        i_nombre = jsonData['Reporter']['names'] + ' ' + jsonData['Reporter']['lastNames'];
        i_ubicacion = jsonData['Lugar']['block'];
        i_salon = jsonData['Lugar']['classroom'].toString(); // Convertido a String
        i_prioridad = jsonData['priority'];
        i_descripcion = jsonData['Lugar']['pointOfReference'];
        isInCase = true;
        aphPhone = jsonData['aphPhone'];
      });
    }
    print('Close_incident_broadcast _setEmergency_2 $Close_incident_broadcast');
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? names = prefs.getString('names') ?? 'Usuario';
    String? lastNames = prefs.getString('lastNames') ?? '';
    String? role = prefs.getString('roles_partition_key') ?? 'Usuario';
    String? roles = prefs.getString('roles') ?? 'Usuario';

    setState(() {
      userName = '$names $lastNames';
      userRole = roles;
      greetingMessage = _getGreetingMessage();
      isBrigadeAccount = (role == 'brigade_accounts');
    });
  }

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

  void _showStatusDialog() {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Actividad del brigadista'),
          content: const Text('¿Quieres cambiar tu estado de actividad?'),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isActive = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Activo'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isActive = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Inactivo'),
                ),

              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();

    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greetingMessage,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: basilTheme?.onSurface),
          ),
          const SizedBox(height: 10),
          Text(
            userName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: basilTheme?.onSurface),
          ),
          const SizedBox(height: 10),
          Text(
            userRole,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurfaceVariant),
          ),
          const SizedBox(height: 10),
          if (isBrigadeAccount)
              isInCase?
              InformeCard(
                  nombre: i_nombre,
                  ubicacion: i_ubicacion,
                  salon: i_salon,
                  descripcion: i_descripcion,
                  prioridad: i_prioridad,
                  aphPhone: aphPhone,
                  onTap: () {}
              ):
                Card(
                clipBehavior: Clip.hardEdge,
                color: basilTheme?.primaryContainer,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estado del brigadista',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                      ),
                      Text(
                        isActive ? 'Activo' : 'Inactivo',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(color: basilTheme?.primary),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Button(
                          text: 'Actualizar estado',
                          width: 160,
                          onClick: _showStatusDialog,
                        ),
                      ),
                    ],
                  )
                ),
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
  final VoidCallback onTap;
  final String aphPhone;

  const InformeCard({
    required this.nombre,
    required this.ubicacion,
    required this.salon,
    required this.descripcion,
    required this.prioridad,
    required this.onTap,
    required this.aphPhone
  });

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            elevation: 3, // Elevación de la tarjeta
            color: basilTheme?.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
              child: Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start ,
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
                            child: Row(
                              children: [
                                Text(
                                  prioridad,
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: basilTheme?.onSurface),
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child:  CallButton(phone: aphPhone),
                      ),
                    ],
                  ),
              ),
            ),

        ],
      ),
    );
  }
}