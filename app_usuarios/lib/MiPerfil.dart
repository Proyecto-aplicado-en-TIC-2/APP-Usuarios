import 'dart:convert';

import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Components/CustonOutlinedButton.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Constants/constants.dart';
import 'package:appv2/EditMyPerfil.dart';
import 'package:appv2/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:http/http.dart' as http;



class MiPerfilScreen extends StatefulWidget {
  const MiPerfilScreen({super.key});


  @override
  _MiPerfilScreenState createState() => _MiPerfilScreenState();
}

class _MiPerfilScreenState extends State<MiPerfilScreen> {
  final WebSocketService _webSocketService = WebSocketService();

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

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Cargar los datos del usuario al iniciar
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
        appBar: const CustonAppbar(automaticallyImplyLeading: true),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Mi perfil',
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
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              names,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: basilTheme?.onSurface),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              roles,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: basilTheme?.onSurface),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Button(text: 'Editar perfil',
                          width: 122,
                          onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditMyPerfil()),
                          );
                        },

                      ),
                      CustonOutlinedButton(text: 'Cerrar sesión',
                          onPressed: () {
                            _webSocketService.disconnect();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          width: 122)
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
                          Text('Correo institucional',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(mail,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Tipo de documentó',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(documentType,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Numero de documentó',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(documentNumber,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Numero de teléfono',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(phone,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Dirección residencial',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(address,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Contacto de emergencia',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(emergencyContactPhoneNumber,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Fecha de nacimiento ',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(birthday,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 30),
                          Text('Información medica ',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Tipo de sangre',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(bloodType,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Alergias',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(allergies,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Medicamentos dependientes',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(dependentMedications,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text('Discapacidad',
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                          Text(disabilities,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: basilTheme?.onSurface),
                          ),
                        ],
                      )
                  )
                ]
            )
        )
    );
  }
}
