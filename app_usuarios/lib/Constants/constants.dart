// lib/constants.dart

class APIConstants {
  static const String baseUrl = 'http://localhost:3000';
  static const String registerEndpoint = '$baseUrl/auth/register/upb-community';
  static const String logInEndpoint = '$baseUrl/auth/login';
  static const String WebSockets_connection = '$baseUrl/WebSocketGateway';
  // Puedes agregar otros endpoints aquí de la misma manera
}