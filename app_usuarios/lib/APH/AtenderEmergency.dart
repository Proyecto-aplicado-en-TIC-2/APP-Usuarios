import 'dart:convert';

import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CallButton.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MiPerfil.dart';
import 'package:http/http.dart' as http;

class APHPrioridadAltaScreen extends StatefulWidget {
  final Map<String, dynamic> incidentData;

  const APHPrioridadAltaScreen({
    Key? key,
    required this.incidentData,
  }) : super(key: key);

  @override
  _APHPrioridadAltaScreenState createState() => _APHPrioridadAltaScreenState();
}

class _APHPrioridadAltaScreenState extends State<APHPrioridadAltaScreen> {

  String idUPB = 'N/A';
  String emergencyContactPhoneNumber = 'N/A';
  String allergies = 'N/A';
  String dependentMedications = 'N/A';
  String disabilities = 'N/A';
  String phone_number = 'N/A';
  String bloodType = 'N/A';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();

  }

  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Obtener la URL completa con el userID desde SharedPreferences
      final url = await APIConstants.GetUserInfoDetails_APH(
          widget.incidentData['reporter']['id'],
          widget.incidentData['location']['roles']);
      print("Fetching reports from URL: $url");  // Verificar la URL

      // Obtener el token de SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt_token');
      if (token == null) {
        throw Exception("Access token not found in SharedPreferences.");
      }

      // Configurar los encabezados de la solicitud con el Bearer Token
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print("Response body: ${response.body}"); // Verificar el cuerpo de la respuesta
        final data = json.decode(response.body);

        if (data.isNotEmpty) {
          setState(() {
            idUPB = data['userDetails']['idUniversity'] != null && data['userDetails']['idUniversity'].isNotEmpty
                ? data['userDetails']['idUniversity']
                : 'N/A';

            emergencyContactPhoneNumber = data['userDetails']['emergencyContactPhoneNumber'] != null && data['userDetails']['emergencyContactPhoneNumber'].isNotEmpty
                ? data['userDetails']['emergencyContactPhoneNumber']
                : 'N/A';

            allergies = data['userDetails']['allergies'] != null && data['userDetails']['allergies'].isNotEmpty
                ? data['userDetails']['allergies']
                : 'N/A';

            dependentMedications = data['userDetails']['dependentMedications'] != null && data['userDetails']['dependentMedications'].isNotEmpty
                ? data['userDetails']['dependentMedications']
                : 'N/A';

            disabilities = data['userDetails']['disabilities'] != null && data['userDetails']['disabilities'].isNotEmpty
                ? data['userDetails']['disabilities']
                : 'N/A';

            phone_number = data['phone_number'] != null && data['phone_number'].isNotEmpty
                ? data['phone_number']
                : '00';
            bloodType = data['userDetails']['bloodType'] != null && data['userDetails']['bloodType'].isNotEmpty
                ? data['userDetails']['bloodType']
                : 'N/A';
          });
        } else {
          print("Response is empty or not in the expected format.");
        }
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load reports: $e');
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
      backgroundColor: basilTheme?.surface,
      appBar: const CustonAppbar(automaticallyImplyLeading: true),
      body: Center(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
          child:  isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Priodidad ${widget.incidentData['priority']}',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: basilTheme?.onSurface),
              ),
              const SizedBox(height: 10,),
              Text(
                '${widget.incidentData['reporter']['names']}${widget.incidentData['reporter']['lastNames']}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: basilTheme?.onSurface),
              ),
              const SizedBox(height: 10,),
              Text(
                '${widget.incidentData['reporter']['relationshipWithTheUniversity']}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
              ),

              const SizedBox(height: 30),

              // Sección de Información del Reportante
              Text(
                'Información personal',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
              ),
              const SizedBox(height: 10),

              buildInfoRow(
                  'Nombre completo',
                  widget.incidentData['reporter']['names'] + widget.incidentData['reporter']['lastNames'] ?? 'N/A', context),
              buildInfoRow(
                  'Id UPB',
                  idUPB,
                  context),
              buildInfoRow(
                  'Contacto de emergencia',
                  emergencyContactPhoneNumber,
                  context),
              buildInfoRow(
                  'Bloque',
                  widget.incidentData['location']['block'] ?? 'N/A',
                  context),
              buildInfoRow(
                  'Salón',
                  widget.incidentData['location']['classroom'].toString(),
                  context),
              buildInfoRow(
                  'Descripción del incidente',
                  widget.incidentData['whatIsHappening'] ?? 'N/A',
                  context),

              const SizedBox(height: 30),
              // Sección de Lugar del Incidente
              Text(
                'Información medica',
                style:  Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
              ),
              const SizedBox(height: 10),

              buildInfoRow(
                  'Medicamentos dependientes',
                  dependentMedications,
                  context),
              buildInfoRow(
                  'Alergias',
                  allergies,
                  context),
              buildInfoRow(
                  'Discapacidad',
                  disabilities,
                  context),
              buildInfoRow(
                  'Tipo de sangre',
                  bloodType,
                  context),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CallButton(phone: phone_number),
                  Button(text: 'En camino',
                      width: 155,
                      onClick: () => {})
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value, BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
          ),
          Text(
            value,
            style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
          )
        ],
      ),
    );
  }
}