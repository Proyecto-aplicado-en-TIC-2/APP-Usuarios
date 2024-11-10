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

  Future<void> _showNotification(String title, String message) async {
    const androidDetails = AndroidNotificationDetails(
      'gloval_warning_channel', 'Global Warnings',
      channelDescription: 'Channel for global warnings',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platformDetails = NotificationDetails(android: androidDetails);
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

    // Escuchar el evento `APH_case`, mostrar notificación y almacenar datos en SharedPreferences
      socket!.on('APH_case', (data) async {
        print('Mensaje de APH_case recibido: $data');
      _showNotification("Caso APH", data.toString());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String caseId = data['Id_reporte'];
      final String caseDataJson = jsonEncode(data);

      await prefs.setString(caseId, caseDataJson);
      print('Datos guardados para el ID de reporte: $caseId');

      newIncidentNotifier.value = !newIncidentNotifier.value;
    });

    // Escuchar el evento `GlovalWarning` y mostrar notificación
    socket!.on('GlovalWarning', (data) {
      print('Mensaje de GlovalWarning recibido: $data');
      _showNotification("Alerta Global", data.toString());
    });

    socket!.on('Report_assign', (data) async {
      print('Report_assign: $data');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('APH_name', data['APH_name']);
      await prefs.setString('APH_phone', data['APH_phone']);
      await prefs.setString('APH_time', data['APH_time']);
      await prefs.setBool('APH_ok', true);
      newIncidentNotifier.value = !newIncidentNotifier.value;
      // Puedes agregar aquí lógica para notificar la actualización en la UI si es necesario
    });

    socket!.on('on_the_way', (data) async {
      print('on_the_way: $data');
      if(data  == true ){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('on_the_way', true);
      }
      newIncidentNotifier.value = !newIncidentNotifier.value;
      // Puedes agregar aquí lógica para notificar la actualización en la UI si es necesario
    });

    socket!.on('Close_incident_broadcast', (data) async {
      print('Close_incident_broadcast: $data');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Close_incident_broadcast', data['Message']);
      newIncidentNotifier.value = !newIncidentNotifier.value;
      // Puedes agregar aquí lógica para notificar la actualización en la UI si es necesario
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

  void disconnect() {
    socket?.disconnect();
    print('WebSocket desconectado manualmente');
  }
}