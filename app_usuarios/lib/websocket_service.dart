import 'package:appv2/Constants/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';

class WebSocketService {
  IO.Socket? socket;

  // Método para conectar el WebSocket
  Future<void> connect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');
    print('Token recuperado: $token'); // Confirma que el token existe

    if (token == null) {
      print('No se encontró el token');
      return;
    }

    // Configura y conecta el WebSocket
    socket = IO.io(
      APIConstants.WebSockets_connection, // URL del WebSocket
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // Para evitar la conexión automática
          .setExtraHeaders({'Authorization': 'Bearer $token'}) // Token en el encabezado
          .build(),
    );

    // Conecta el WebSocket
    socket!.connect();

    // Escucha eventos del WebSocket
    socket!.onConnect((_) {
      print('Conexión exitosa al WebSocket');
    });

    socket!.on('Connexion_Exitosa', (data) {
      print('Mensaje del servidor: $data');
    });

    // Manejador de desconexión
    socket!.onDisconnect((_) => print('Desconectado del WebSocket'));
  }

  // Método para desconectar el WebSocket
  void disconnect() {
    socket?.disconnect();
    print('WebSocket desconectado manualmente');
  }
}