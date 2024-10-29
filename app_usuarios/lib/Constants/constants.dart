// lib/constants.dart

class APIConstants {
  static const String local = 'http://localhost:3000';
  static const String azure_testing = 'https://gdr-container-testing.livelybay-5b00af3d.centralus.azurecontainerapps.io';

  static const String baseUrl = azure_testing;
  static const String registerEndpoint = '$baseUrl/auth/register/upb-community';
  static const String logInEndpoint = '$baseUrl/auth/login';
  static const String WebSockets_connection = '$baseUrl/WebSocketGateway';
  static const String Register = '$baseUrl/auth/register/upb-community';
// Puedes agregar otros endpoints aquí de la misma manera
}