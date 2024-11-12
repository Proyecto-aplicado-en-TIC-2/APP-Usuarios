import 'dart:convert';

import 'package:appv2/APH/CustonBottomNavigationBar.dart';
import 'package:appv2/Brigadistas/BrigaHome.dart';
import 'package:appv2/Components/Box.dart';
import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Components/CustonAppbarProfile.dart';
import 'package:appv2/Components/CustonOutlinedButton.dart';
import 'package:appv2/Components/buildDropdownField.dart';
import 'package:appv2/Components/enums.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Constants/constants.dart';
import 'package:appv2/MiPerfil.dart';
import 'package:appv2/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class EditMyPerfil extends StatefulWidget {
  const EditMyPerfil({super.key});

  @override
  _EditMyPerfil createState() => _EditMyPerfil();
}

class _EditMyPerfil extends State<EditMyPerfil> {
  final WebSocketService _webSocketService = WebSocketService();

  final TextEditingController namesController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController idUniversityController = TextEditingController();
  final TextEditingController documentTypeController = TextEditingController();
  final TextEditingController documentNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emergencyContactPhoneNumberController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController dependentMedicationsController = TextEditingController();
  final TextEditingController disabilitiesController = TextEditingController();

  bool isLoading = false;


  String roles = 'Error';
  String userId = 'Error' ;
  String names = 'Error' ;
  String lastName = 'Error';
  String mail = 'Error';

  String phone = 'Error';
  String idUniversity = 'Error';
  String documentType = 'Error';
  String documentNumber = 'Error' ;
  String address = 'Error';
  String emergencyContactPhoneNumber = 'Error';
  String birthday = 'Error';
  String bloodType = 'Error' ;
  String allergies = 'Error' ;
  String dependentMedications = 'Error';
  String disabilities = 'Error';
  bool in_service = false;
  String quadrant = 'Error';

  @override
  void initState() {
    if(mounted){
      super.initState();
      _loadUserData(); // Cargar los datos del usuario al iniciar
    }
  }

  // Cargar los datos almacenados en SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      roles = prefs.getString('roles') ?? 'Sin asignar';
      userId = prefs.getString('userid') ?? 'Sin asignar';
      names = prefs.getString('names') ?? 'Sin asignar';
      lastName = prefs.getString('lastNames') ?? 'Sin asignar';
      mail = prefs.getString('mail') ?? 'Sin asignar';
      phone = prefs.getString('phone_number') ?? 'Sin asignar';
      bloodType = prefs.getString('bloodType') ?? 'Sin asignar';

      idUniversity = prefs.getString('idUniversity') ?? 'Sin asignar';
      documentType = prefs.getString('documentType') ?? 'Sin asignar';
      documentNumber = prefs.getString('documentNumber') ?? 'Sin asignar';
      address = prefs.getString('address') ?? 'Sin asignar';
      emergencyContactPhoneNumber = prefs.getString('emergencyContactPhoneNumber') ?? 'Sin asignar';
      birthday = prefs.getString('birthday') ?? 'Sin asignar';
      allergies = prefs.getString('allergies') ?? 'Sin asignar';
      dependentMedications = prefs.getString('dependentMedications') ?? 'Sin asignar';
      disabilities = prefs.getString('disabilities') ?? 'Sin asignar';

      in_service = prefs.getBool('in_service') ?? false;
      quadrant = prefs.getString('quadrant') ?? 'Sin asignar';

    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        birthdayController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }
  Future<void> _SaveUserDetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final url = await APIConstants.updateUserDetails();
      String? token = prefs.getString('jwt_token');
      if (token == null) {
        throw Exception("Access token not found in SharedPreferences.");
      }

      // Configurar los encabezados de la solicitud con el Bearer Token
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      String partitionKey = prefs.getString('roles_partition_key') ?? '';
      String relationshipWithTheUniversity = prefs.getString('relationshipWithTheUniversity') ?? '';

      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({
          "partition_key": partitionKey,
          "id": userId,
          "names": namesController.text.isNotEmpty ? namesController.text : names,
          "last_names": lastNameController.text.isNotEmpty ? lastNameController.text : lastName,
          "mail": mailController.text.isNotEmpty ? mailController.text : mail,
          "phone_number": phoneController.text.isNotEmpty ? phoneController.text : phone,
          "relationshipWithTheUniversity": relationshipWithTheUniversity,
          "in_service" : in_service,
          "quadrant" : quadrant,
          "userDetails": {
            "idUniversity": idUniversityController.text.isNotEmpty ? idUniversityController.text : idUniversity,
            "documentType": documentTypeController.text.isNotEmpty ? documentTypeController.text : documentType,
            "documentNumber": documentNumberController.text.isNotEmpty ? documentNumberController.text : documentNumber,
            "address": addressController.text.isNotEmpty ? addressController.text : address,
            "emergencyContactPhoneNumber": emergencyContactPhoneNumberController.text.isNotEmpty ? emergencyContactPhoneNumberController.text : emergencyContactPhoneNumber,
            "birthday": birthdayController.text.isNotEmpty ? birthdayController.text : birthday,
            "bloodType": bloodTypeController.text.isNotEmpty ? bloodTypeController.text : bloodType,
            "allergies": allergiesController.text.isNotEmpty ? allergiesController.text : allergies,
            "dependentMedications": dependentMedicationsController.text.isNotEmpty ? dependentMedicationsController.text : dependentMedications,
            "disabilities": disabilitiesController.text.isNotEmpty ? disabilitiesController.text : disabilities,
          }
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        await prefs.setString('phone_number', responseData['phone_number'] ?? '');
        await prefs.setString('names', responseData['names'] ?? '');
        await prefs.setString('lastName', responseData['lastName'] ?? '');
        await prefs.setString('idUniversity', responseData['userDetails']?['idUniversity'] ?? '');
        await prefs.setString('documentType', responseData['userDetails']?['documentType'] ?? '');
        await prefs.setString('documentNumber', responseData['userDetails']?['documentNumber'] ?? '');
        await prefs.setString('address', responseData['userDetails']?['address'] ?? '');
        await prefs.setString('emergencyContactPhoneNumber', responseData['userDetails']?['emergencyContactPhoneNumber'] ?? '');
        await prefs.setString('birthday', responseData['userDetails']?['birthday'] ?? '');
        await prefs.setString('bloodType', responseData['userDetails']?['bloodType'] ?? '');
        await prefs.setString('allergies', responseData['userDetails']?['allergies'] ?? '');
        await prefs.setString('dependentMedications', responseData['userDetails']?['dependentMedications'] ?? '');
        await prefs.setString('disabilities', responseData['userDetails']?['disabilities'] ?? '');

        // Mostrar SnackBar de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Operacn exitosa')),
        );
        String? roles_partition_key =  prefs.getString('roles_partition_key');
        // Regresar a la pantalla anterior después de que se complete la operación
        if (roles_partition_key == 'prehospital_care_accounts') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CustomBottomNavigation(initialIndex: 0,)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  const BrigaHomescreen()),
          );
        }
      } else {
        throw Exception('Error en la operación. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      // Mostrar SnackBar de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar los datos: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    namesController.dispose();
    lastNameController.dispose();
    mailController.dispose();
    phoneController.dispose();
    idUniversityController.dispose();
    documentTypeController.dispose();
    documentNumberController.dispose();
    addressController.dispose();
    emergencyContactPhoneNumberController .dispose();
    birthdayController.dispose();
    bloodTypeController.dispose();
    allergiesController.dispose();
    dependentMedicationsController.dispose();
    disabilitiesController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
        appBar: const CustonAppbarProfile(automaticallyImplyLeading: true),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Actualizar perfil',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: basilTheme?.onSurface),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/perfilexample.jpg'),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Button(
                              text: 'Cambiar imagen',
                              width: 153,
                              onClick: () {  },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Información personal',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Box(topLabel: 'Nombres',
                              bottomHelperText: names,
                              controller: namesController,
                              inputType: TextInputType.name
                          ),
                          Box(topLabel: 'Apellidos',
                              bottomHelperText: lastName,
                              controller: lastNameController,
                              inputType: TextInputType.name
                          ),
                          Box(topLabel: 'Correo institucional',
                              bottomHelperText: mail,
                              controller: mailController,
                              inputType: TextInputType.emailAddress
                          ),
                          BuildDropdownField<DocumetType>(
                            topLabel: 'Tipo de documentó',
                            bottomHelperText: documentType,
                            items: DocumetType.values,
                            controller: documentTypeController,
                          ),
                          Box(topLabel: 'Numero de documentó',
                              bottomHelperText: documentNumber,
                              controller: documentNumberController,
                              inputType: TextInputType.number
                          ),
                          Box(topLabel: 'Id universitarian (carned)',
                              bottomHelperText: idUniversity,
                              controller: idUniversityController,
                              inputType: TextInputType.emailAddress
                          ),
                          Box(topLabel: 'Numero de teléfono',
                              bottomHelperText: phone,
                              controller: phoneController,
                              inputType: TextInputType.phone
                          ),
                          Box(topLabel: 'Dirección residencial',
                              bottomHelperText: address,
                              controller: addressController,
                              inputType: TextInputType.streetAddress
                          ),
                          Box(topLabel: 'Contacto de emergencia',
                              bottomHelperText: emergencyContactPhoneNumber,
                              controller: emergencyContactPhoneNumberController,
                              inputType: TextInputType.phone
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: Box(
                                topLabel: 'Fecha de nacimiento',
                                bottomHelperText: birthday,
                                controller: birthdayController,
                                inputType: TextInputType.datetime,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          Text('Información medica ',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          BuildDropdownField<BloodType>(
                            topLabel: 'Tipo de sangre',
                            bottomHelperText: bloodType,
                            items: BloodType.values,
                            controller: bloodTypeController,
                          ),
                          Box(topLabel: 'Alergias',
                              bottomHelperText: allergies,
                              controller: allergiesController,
                              inputType: TextInputType.text
                          ),
                          Box(topLabel: 'Medicamentos dependientes',
                              bottomHelperText: dependentMedications,
                              controller: dependentMedicationsController,
                              inputType: TextInputType.text
                          ),
                          Box(topLabel: 'Discapacidad',
                              bottomHelperText: disabilities,
                              controller: disabilitiesController,
                              inputType: TextInputType.text
                          ),
                        ],
                      ),
                  ),
                  Container(
                    padding:  const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustonOutlinedButton(
                          text: 'Cancelar',
                          width: 105,
                          onPressed: () => Navigator.pop(context),
                        ),
                        Button(
                          text: 'Actualizar perfil',
                          width: 149,
                          onClick: () async => await _SaveUserDetails(),
                        )
                      ],
                    ),
                  )
                ]
            )
        )
    );
  }
}
