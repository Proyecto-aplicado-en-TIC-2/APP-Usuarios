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

    socket!.onDisconnect((_) => print('Desconectado del WebSocket'));
  }

  void sendReport(Map<String, dynamic> reportData, Function(String) onMessageSent) {
    socket?.emit('report', reportData);
    socket?.on('Mensaje_Enviado', (data) {
      onMessageSent(data);
    });
  }

  void disconnect() {
    socket?.disconnect();
    print('WebSocket desconectado manualmente');
  }
}