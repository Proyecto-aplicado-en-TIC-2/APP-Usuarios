import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<void> _showNotification(String title, String message, String _summaryText) async {
    var androidDetails = AndroidNotificationDetails(
      'showNotification_UPBSegura',
      'showNotification_UPBSegura',
      channelDescription: 'Channel for showNotification_UPBSegura',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,

      styleInformation: BigTextStyleInformation(
        message,
        contentTitle: title,
        summaryText: _summaryText,
      ),
      playSound: true, // Activar sonido personalizado si se desea
    );
    var platformDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      0, title, message, platformDetails,
    );
  }


  Future<void> _showNotificationGlovalWarning(String title, String message,) async {
    var androidDetails = AndroidNotificationDetails(
      'gloval_warning_channel',
      'Global Warnings',
      channelDescription: 'Channel for global warnings',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,

      styleInformation: BigTextStyleInformation(
        message,
        contentTitle: title,
        summaryText: 'Atención',
      ),
      playSound: true, // Activar sonido personalizado si se desea
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

    // Escuchar el evento `APH_case`, mostrar notificación y almacenar datos en SharedPreferences
    socket!.on('APH_case', (data) async {
      print('Mensaje de APH_case recibido: $data');

      _showNotification(
        "Nuevo caso asignado",
        'Se le a asignado un caso nuevo revisar sus casos asignados',
        'Caso'
      );

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
      print(data['data']['emergencia'].toString());

      if (data['data']['emergencia'].toString() == 'Simulacro') {
        _showNotificationGlovalWarning(
            "Simulacro",
            'Esto es un simulacro evacuar de manera ordenada'
        );
      } else {
        _showNotificationGlovalWarning(
            "Alerta Global!!!",
            'Esto no es un simulacro se detectó un ${data['data']['emergencia']} '
                'Por favor evacuar en base a los protocolos de seguridad'
        );
      }
    });



    socket!.on('Report_assign', (data) async {
      print('Report_assign: $data');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('APH_name', data['APH_name']);
      await prefs.setString('APH_phone', data['APH_phone']);
      await prefs.setString('APH_time', data['APH_time']);
      await prefs.setBool('APH_ok', true);
      _showNotification(
          "Informe asignado",
          'Se le a asignado un APH en espera de una confirmacion ',
          'APH asignado'
      );
      newIncidentNotifier.value = !newIncidentNotifier.value;
      // Puedes agregar aquí lógica para notificar la actualización en la UI si es necesario
    });

    socket!.on('on_the_way', (data) async {
      print('on_the_way: $data');
      if(data  == true ){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('on_the_way', true);
      }
      _showNotification(
          "En camino",
          'El aph a confirmado su caso y va en camino ',
          'APH en camino'
      );
      newIncidentNotifier.value = !newIncidentNotifier.value;
      // Puedes agregar aquí lógica para notificar la actualización en la UI si es necesario
    });

    socket!.on('Brigadista_case_assigned', (data) async {
      print('Brigadista_case_assigned: $data');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Obtener el mapa actual de asignaciones de brigadistas
      Map<String, dynamic> brigadistaAssignments = Map<String, dynamic>.from(
          jsonDecode(prefs.getString('brigadistaAssignments') ?? '{}'));

      // Agregar la nueva asignación al mapa
      brigadistaAssignments[data['case_id']] = {
        'names': data['names'],
        'lastNames': data['lastNames'],
        'phone_number': data['phone_number']
      };

      // Guardar el mapa actualizado en SharedPreferences
      await prefs.setString('brigadistaAssignments', jsonEncode(brigadistaAssignments));
      _showNotification(
          "Brigadista ayudante",
          'Se le a asignado un brigadista para que lo acompañe en el caso',
          'Brigadista en camino'
      );
      // Notificar cambios
      WebSocketService.newIncidentNotifier.value = !WebSocketService.newIncidentNotifier.value;
    });

    socket!.on('Brigadista_case', (data) async {
      print('Brigadista_case: $data');

      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Convierte el objeto JSON en una cadena antes de guardarlo
      String jsonData = jsonEncode(data);

      await prefs.setString('Brigadista_case', jsonData);

          _showNotification(
          "Asignado a un caso",
          'Se le a asignado como un acompañe en un caso dirijirse en el acompañamiento de del APH',
          'dirijirse al caso'
      );
      newIncidentNotifier.value = !newIncidentNotifier.value;

      // Puedes agregar aquí lógica para notificar la actualización en la UI si es necesario
    });
    socket!.on('Close_incident_broadcast', (data) async {
      print('Close_incident_broadcast: $data');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('Close_incident_broadcast', true);
      _showNotification(
          "Caso cerrado",
          'Se a cerrado el caso correctamente',
          ''
      );

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