import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:appv2/Constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

class WebSocketService {
  IO.Socket? socket;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static final ValueNotifier<bool> newIncidentNotifier = ValueNotifier(false);
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;

  WebSocketService._internal() {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    flutterLocalNotificationsPlugin.initialize(initSettings);
    _requestNotificationPermission();
    connect();
  }

  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  Future<void> _showNotification(String title,
      String message, {
        Color color = Colors.blue,
        IconData icon = Icons.notification_important}) async {
    const channelId = 'notifications_channel';
    const channelName = 'Alerts';
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Custom notifications for different socket events',
      importance: Importance.max,
      priority: Priority.high,
      color: color,
      styleInformation: BigTextStyleInformation(message), // Allows for larger message text
      icon: icon.codePoint.toString(), // Custom icon
    );
    var platformDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      0, title, message, platformDetails,
    );
  }

  Future<void> connect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');
    print('Token recuperado: $token');

    if (token == null) {
      print('No se encontró el token');
      return;
    }

    socket = IO.io(
      APIConstants.WebSockets_connection,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      print('Conexión exitosa al WebSocket');
    });

    // Custom alerts for each socket event

    socket!.on('APH_case', (data) async {
      print('Mensaje de APH_case recibido: $data');
      _showNotification("Caso APH", "Nuevo caso recibido", color: Colors.red, icon: Icons.warning);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String caseId = data['Id_reporte'];
      final String caseDataJson = jsonEncode(data);
      await prefs.setString(caseId, caseDataJson);
      newIncidentNotifier.value = !newIncidentNotifier.value;
    });

    socket!.on('GlovalWarning', (data) {
      print('Mensaje de GlovalWarning recibido: $data');
      _showNotification("Alerta Global", "Se ha emitido una alerta global. Detalles: $data", color: Colors.orange, icon: Icons.announcement);
    });

    socket!.on('Report_assign', (data) async {
      print('Report_assign: $data');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('APH_name', data['APH_name']);
      await prefs.setString('APH_phone', data['APH_phone']);
      await prefs.setString('APH_time', data['APH_time']);
      _showNotification("Reporte Asignado", "Se le ha asignado un nuevo reporte.", color: Colors.green, icon: Icons.assignment);
      newIncidentNotifier.value = !newIncidentNotifier.value;
    });

    socket!.on('on_the_way', (data) async {
      print('on_the_way: $data');
      if (data == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('on_the_way', true);
      }
      _showNotification("En Camino", "Un brigadista está en camino para el caso.", color: Colors.blueAccent, icon: Icons.directions_run);
      newIncidentNotifier.value = !newIncidentNotifier.value;
    });

    socket!.on('Brigadista_case_assigned', (data) async {
      print('Brigadista_case_assigned: $data');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> brigadistaAssignments = Map<String, dynamic>.from(
          jsonDecode(prefs.getString('brigadistaAssignments') ?? '{}'));
      brigadistaAssignments[data['case_id']] = {
        'names': data['names'],
        'lastNames': data['lastNames'],
        'phone_number': data['phone_number']
      };
      await prefs.setString('brigadistaAssignments', jsonEncode(brigadistaAssignments));
      _showNotification("Caso Asignado", "Se le ha asignado un caso como brigadista.", color: Colors.purple, icon: Icons.add_task);
      newIncidentNotifier.value = !newIncidentNotifier.value;
    });

    socket!.on('Brigadista_case', (data) async {
      print('Brigadista_case: $data');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Brigadista_case', jsonEncode(data));
      _showNotification("Nuevo Caso de Brigadista", "Detalles: $data", color: Colors.teal, icon: Icons.campaign);
      newIncidentNotifier.value = !newIncidentNotifier.value;
    });

    socket!.on('Close_incident_broadcast', (data) async {
      print('Close_incident_broadcast: $data');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('Close_incident_broadcast', true);
      _showNotification("Caso Cerrado", "Se ha cerrado un incidente.", color: Colors.grey, icon: Icons.close);
      newIncidentNotifier.value = !newIncidentNotifier.value;
    });

    socket!.onDisconnect((_) => print('Desconectado del WebSocket'));
  }

  void closeReport(Map<String, dynamic> reportData, Function(String) onMessageSent) {
    socket?.emit('APH', reportData);
    socket?.on('close_case', (data) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('close_case', data);
      print(data);
      onMessageSent(data);
    });
    newIncidentNotifier.value = !newIncidentNotifier.value;
  }
  void brigadistaUpdateState(Map<String, dynamic> reportData, Function(String) onMessageSent) {
    socket?.emit('Brigadiers', reportData);

    socket?.on('Brigadier_update_state_confirmation', (data) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Convertir el mapa `data` a una cadena JSON
      String jsonData = jsonEncode(data);
      await prefs.setString('Brigadier_update_state_confirmation', jsonData);

      print(jsonData);
      onMessageSent(jsonData); // Envía la cadena JSON de vuelta como mensaje
    });

    newIncidentNotifier.value = !newIncidentNotifier.value;
  }

  void onTheWay(Map<String, dynamic> reportData, Function(String) onMessageSent) {
    socket?.emit('APH', reportData);
    socket?.on('on_the_way_aph', (data) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('on_the_way_aph', data);
      print(data);
      onMessageSent(data);
    });

  }

  void sendReport(Map<String, dynamic> reportData, Function(String) onMessageSent) {
    socket?.emit('report', reportData);
    socket?.on('Mensaje_Enviado', (data) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Mensaje_Enviado', data);
      print(data);
      onMessageSent(data);
    });
    newIncidentNotifier.value = !newIncidentNotifier.value;
  }

  void AskForHelp_brigadier(Map<String, dynamic> reportData, Function(String) onMessageSent) {
    socket?.emit('APH', reportData);
    socket?.on('Aph_help_confirm', (data) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Aph_help_confirm', data);
      print(data);
      onMessageSent(data);
    });
    newIncidentNotifier.value = !newIncidentNotifier.value;
  }


  void disconnect() {
    socket?.disconnect();
    print('WebSocket desconectado manualmente');
  }
}