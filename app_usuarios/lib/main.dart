import 'package:appv2/Components/Box.dart';
import 'package:appv2/Components/Button.dart';
import 'package:appv2/APH/CustonBottomNavigationBar.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Constants/theme.dart';
import 'package:appv2/Registro.dart';
import 'package:appv2/websocket_service.dart'; // Importa tu servicio de WebSocket
import 'package:appv2/Brigadistas/BrigaHome.dart';
import 'package:appv2/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Asegúrate de importar RegisterScreen aquí


import 'APH/aphome.dart';
import 'Components/BoxIsPassword.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const basilTheme = BasilTheme();

    return MaterialApp(
      title: 'Gestion de riesgos UPB',
      theme: basilTheme.toThemeData(), // Aplica BasilTheme como tema principal
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> loginUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    final String email = emailController.text.trim();
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    final Uri url = Uri.parse(APIConstants.logInEndpoint);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mail': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['operation'] == true && responseData['access_token'] != null) {
          final String token = responseData['access_token'] ?? 'Sin asignar';
          final String roles = responseData['roles'] ?? 'Sin asignar';
          final String userid = responseData['userid'] ?? 'Sin asignar';
          final String names = responseData['names'] ?? 'Sin asignar';
          final String lastName = responseData['lastNames'] ?? 'Sin asignar';
          final String mail = responseData['mail'] ?? 'Sin asignar';
          final String phone_number = responseData['phone_number'] ?? 'Sin asignar';
          final String relationshipWithTheUniversity = responseData['relationshipWithTheUniversity'] ?? 'Sin asignar';

          final String idUniversity = responseData['userDetails']?['idUniversity']?.toString() ?? 'Sin asignar';
          final String documentType = responseData['userDetails']?['documentType'] ?? 'Sin asignar';
          final String documentNumber = responseData['userDetails']?['documentNumber'] ?? 'Sin asignar';
          final String address = responseData['userDetails']?['address'] ?? 'Sin asignar';
          final String emergencyContactPhoneNumber = responseData['userDetails']?['emergencyContactPhoneNumber']?.toString() ?? '';
          final String birthday = responseData['userDetails']?['birthday'] ?? 'Sin asignar';
          final String bloodType = responseData['userDetails']?['bloodType'] ?? 'Sin asignar';
          final String allergies = responseData['userDetails']?['allergies'] ?? 'Sin asignar';
          final String dependentMedications = responseData['userDetails']?['dependentMedications'] ?? 'Sin asignar';
          final String disabilities = responseData['userDetails']?['disabilities'] ?? 'Sin asignar';

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);
          if(roles == 'upb_community_accounts'){
            await prefs.setString('roles', 'Comunidad UPB');
          }
          if(roles == 'prehospital_care_accounts'){
            await prefs.setString('roles', 'APH');
          }
          if(roles == 'brigade_accounts'){
            await prefs.setString('roles', 'Brigadista');
          }
          await prefs.setString('relationshipWithTheUniversity', relationshipWithTheUniversity);
          await prefs.setString('roles_partition_key', roles);
          await prefs.setString('userid', userid);
          await prefs.setString('names', names);
          await prefs.setString('lastNames', lastName);
          await prefs.setString('mail', mail);
          await prefs.setString('phone_number', phone_number);

          await prefs.setString('idUniversity', idUniversity);
          await prefs.setString('documentType', documentType);
          await prefs.setString('documentNumber', documentNumber);
          await prefs.setString('address', address);
          await prefs.setString('emergencyContactPhoneNumber', emergencyContactPhoneNumber);
          await prefs.setString('birthday', birthday);
          await prefs.setString('bloodType', bloodType);
          await prefs.setString('allergies', allergies);
          await prefs.setString('dependentMedications', dependentMedications);
          await prefs.setString('disabilities', disabilities);

          final webSocketService = WebSocketService();
          await webSocketService.connect();

          if (roles == 'prehospital_care_accounts') {
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error en la operación de inicio de sesión')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en el inicio de sesión: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la conexión: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


    @override
    Widget build(BuildContext context) {
      final basilTheme = Theme.of(context).extension<BasilTheme>();

      return Scaffold(
      backgroundColor:  basilTheme?.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/Logo_UPB.png',
                    height: 144,
                    width: 144
                  ),

                const SizedBox(height: 30),

                Text(
                  'Inicio de sesión',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: basilTheme?.onSurface)
                ),

                const SizedBox(height: 30),
                Box(
                  topLabel: 'Correo',
                  bottomHelperText: 'Ingresa tu correo institucional de preferencia',
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                Boxispassword(
                    topLabel: 'Contraseña',
                    bottomHelperText: 'Ingresa tu contraseña',
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                    child: Text(
                    'Olvide mi contraseña!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.primary),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                 child:  Button(
                    text: 'Iniciar sesión',
                    width: 133,
                    onClick: () => loginUser(context),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                      child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                        children: [
                          TextSpan(text: '¿No tienes cuenta? '),
                          TextSpan(
                            text: 'Regístrate !',
                            style: TextStyle(color: basilTheme?.primary), // Cambia solo "Regístrate !" a otro color
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}