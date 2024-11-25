import 'package:shared_preferences/shared_preferences.dart';

class APIConstants{

  static const String local = 'http://localhost:3000';
  static const String azure_testing = 'https://gdr-container-testing.wonderfulforest-6ce2d1ba.centralus.azurecontainerapps.io/';
  static const String baseUrl = azure_testing;
  static const String registerEndpoint = '$baseUrl/auth/register/upb-community';
  static const String logInEndpoint = '$baseUrl/auth/login';
  static const String WebSockets_connection = '$baseUrl/WebSocketGateway';
  static const String Register = '$baseUrl/auth/register/upb-community';



  static Future<String> GetAphQuadrant() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userid');

    return '$baseUrl/prehospital-care/$userID';
  }

  static Future<String> GetWebSocketInfo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userid');

    return '$baseUrl/websockets/GetWebSocketInfo/$userID';


  }

  static Future<String> GetUserInfoDetails_APH(String userId, String roles) async {

    if(roles == 'upb_community_accounts'){
      return '$baseUrl/community/$userId';

    }else if(roles == 'prehospital_care_accounts'){
      return '$baseUrl/prehospital-care/$userId';

    }else{
      return '$baseUrl/brigadiers/$userId';
    }

  }

  static Future<String> updateUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userid');
    String? roles = prefs.getString('roles_partition_key');
    if (userID == null) {
      throw Exception("UserID not found in SharedPreferences.");
    }
    if(roles == 'upb_community_accounts'){
      return '$baseUrl/community/$userID';

    }else if(roles == 'prehospital_care_accounts'){
      return '$baseUrl/prehospital-care/$userID';

    }else{
      return '$baseUrl/brigadiers/$userID';
    }
  }

  // Método para obtener userID desde SharedPreferences y construir la URL
  static Future<String> getAllReportsEndpoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userid');

    if (userID == null) {
      throw Exception("UserID not found in SharedPreferences.");
    }

    return '$baseUrl/incidents/IncidentIdsById/$userID';
  }
  static Future<String> getAllCloseReportsEndpoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('userid');

    if (userID == null) {
      throw Exception("UserID not found in SharedPreferences.");
    }

    return '$baseUrl/emergency-reports/GetReportsClosedIdsById/$userID';
  }
}



