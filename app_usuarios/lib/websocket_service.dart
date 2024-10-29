import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:appv2/Constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class WebSocketService {
  IO.Socket? socket;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  WebSocketService() {
    // Configuración inicial de notificaciones
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    flutterLocalNotificationsPlugin.initialize(initSettings);

    // Solicitar permisos de notificación en Android 13+
    _requestNotificationPermission();
  }

  Future<void> _requestNotificationPermission() async {
    // Usar permission_handler para solicitar permisos de notificación en Android 13+
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  // Método para mostrar una notificación
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

  // Método para conectar el WebSocket
  Future<void> connect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');
    print('Token recuperado: $token');

    if (token == null) {
      print('No se encontró el token');
      return;
    }

    // Configura y conecta el WebSocket
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

    // Escuchar el evento `GlovalWarning` y mostrar notificación
    socket!.on('GlovalWarning', (data) {
      print('Mensaje de GlovalWarning recibido: $data');
      _showNotification("Advertencia Global", data.toString());
    });

    socket!.onDisconnect((_) => print('Desconectado del WebSocket'));
  }

  // Método para enviar un reporte al servidor
  void sendReport(Map<String, dynamic> reportData, Function(String) onMessageSent) {
    socket?.emit('report', reportData);
    socket?.on('Mensaje_Enviado', (data) {
      onMessageSent(data);
    });
  }

  // Método para desconectar el WebSocket manualmente
  void disconnect() {
    socket?.disconnect();
    print('WebSocket desconectado manualmente');
  }
}