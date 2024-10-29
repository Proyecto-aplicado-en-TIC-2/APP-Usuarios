import 'package:shared_preferences/shared_preferences.dart';

class APIConstants {
  static const String local = 'http://localhost:3000';
  static const String azure_testing = 'https://gdr-container-testing.livelybay-5b00af3d.centralus.azurecontainerapps.io';
  static const String baseUrl = azure_testing;
  static const String registerEndpoint = '$baseUrl/auth/register/upb-community';
  static const String logInEndpoint = '$baseUrl/auth/login';
  static const String WebSockets_connection = '$baseUrl/WebSocketGateway';
  static const String Register = '$baseUrl/auth/register/upb-community';

  // Método para obtener userID desde SharedPreferences y construir la URL
  static Future<String> getAllReportsEndpoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userid');

    if (userID == null) {
      throw Exception("UserID not found in SharedPreferences.");
    }

    return '$baseUrl/incidents/IncidentIdsById/$userID';
  }
}