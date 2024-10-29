import 'package:appv2/Constants/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';

class WebSocketService {
  IO.Socket? socket;

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

    // Conecta el WebSocket
    socket!.connect();

    socket!.onConnect((_) {
      print('Conexión exitosa al WebSocket');
    });

    // Escuchar el evento `GlovalWarning`
    socket!.on('GlovalWarning', (data) {
      print('Mensaje de GlovalWarning recibido: $data');
      // Aquí puedes agregar cualquier acción adicional que quieras hacer con el mensaje
    });

    socket!.onDisconnect((_) => print('Desconectado del WebSocket'));
  }

  // Método para enviar el reporte al servidor
  void sendReport(Map<String, dynamic> reportData, Function(String) onMessageSent) {
    // Enviar el evento `report`
    socket?.emit('report', reportData);

    // Escuchar el evento `Mensaje_Enviado` y ejecutar el callback con el mensaje
    socket?.on('Mensaje_Enviado', (data) {
      onMessageSent(data);
    });
  }

  void disconnect() {
    socket?.disconnect();
    print('WebSocket desconectado manualmente');
  }
}