
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Components/EmergencyCallbox.dart';
import 'package:appv2/Components/EmergencyLayout.dart';
import 'package:appv2/Components/EmergencyState_1.dart';
import 'package:appv2/Components/EmergencyState_2.dart';
import 'package:appv2/Components/EmergencyState_3.dart';
import 'package:appv2/Components/Line.dart';
import 'package:appv2/Components/UserHello.dart';
import 'package:appv2/Constants/my_flutter_app_icons.dart';
import 'package:appv2/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/AppColors.dart';

enum EmergencyState {
  sent, // Estado cuando se envía el reporte
  received, // Estado cuando se recibe una confirmación
  inProgress, // Estado cuando la ayuda está en camino
  closed
}

class BrigaHomescreen extends StatefulWidget {
  const BrigaHomescreen({super.key});




  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<BrigaHomescreen> {
  EmergencyState? _emergencyState;

  @override
  void initState() {
    super.initState();
    _checkEmergencyStatus();
    WebSocketService.newIncidentNotifier.addListener(_incidentListener);
  }

  void _incidentListener() {
    if (mounted) {
      setState(() {
        _checkEmergencyStatus();
      });
    }
  }

  @override
  void dispose() {
    WebSocketService.newIncidentNotifier.removeListener(_incidentListener);
    super.dispose();
  }

  Future<void> _checkEmergencyStatus() async {
    if (!mounted) return; // Asegúrate de que el widget esté en el árbol

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? onTheWay = prefs.getBool('on_the_way');
    bool? APH_ok = prefs.getBool('APH_ok');
    String? Mensaje_Enviado = prefs.getString('Mensaje_Enviado');
    String? Close_incident_broadcast = prefs.getString('Close_incident_broadcast');

    if (Close_incident_broadcast != null && Close_incident_broadcast.isNotEmpty && mounted) {
      print('cerrado');
      setState(() {
        _emergencyState = EmergencyState.closed;
      });
      await prefs.setBool('on_the_way', false);
      await prefs.setBool('APH_ok', false);
      await prefs.setString('Mensaje_Enviado', '');
      await prefs.setString('Close_incident_broadcast', '');
    } else if (Mensaje_Enviado != null && Mensaje_Enviado.isNotEmpty && mounted) {
      print('EmergencyState_1');
      setState(() {
        _emergencyState = EmergencyState.sent;
      });
      await prefs.setString('Mensaje_Enviado', '');
    } else if (APH_ok == true && mounted) {
      print('EmergencyState_2');
      setState(() {
        _emergencyState = EmergencyState.received;
      });
      await prefs.setBool('APH_ok', false);
    } else if (onTheWay == true && mounted) {
      print('EmergencyState_3');
      setState(() {
        _emergencyState = EmergencyState.inProgress;
      });
      await prefs.setBool('on_the_way', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
      appBar: const CustonAppbar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserHello(),
            if (_emergencyState == EmergencyState.sent)
              const EmergencyState_1(),
            if (_emergencyState == EmergencyState.received)
              const EmergencyState_2(),
            if (_emergencyState == EmergencyState.inProgress)
              const EmergencyState_3(),
            const SizedBox(height: 30),
            const EmergencyLayout(),
            const SizedBox(height: 30),
            Text(
              'Llamada de emergencia',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 10),
            const EmergencyCallBox(),
          ],
        ),
      ),
    );
  }
}