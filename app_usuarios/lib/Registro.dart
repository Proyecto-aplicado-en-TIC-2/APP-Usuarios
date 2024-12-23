import 'package:appv2/Components/Box.dart';
import 'package:appv2/Components/BoxIsPassword.dart';
import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CustonOutlinedButton.dart';
import 'package:appv2/Components/buildDropdownField.dart';
import 'package:appv2/Components/enums.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/Constants/constants.dart';
import 'package:appv2/main.dart';
import 'package:appv2/websocket_service.dart';
import 'package:appv2/Brigadistas/BrigaHome.dart';
import 'package:appv2/APH/aphome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController relationshipWithTheUniversityController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  Future<void> registerUser(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final String relationshipWithTheUniversity = relationshipWithTheUniversityController.text.trim();
    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String phone = phoneController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    final Uri url = Uri.parse(APIConstants.registerEndpoint);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'password': password,
          'user': {
            'names': firstName,
            'last_names': lastName,
            'mail': email,
            'phone_number': phone,
            'relationshipWithTheUniversity': relationshipWithTheUniversity
          },
        }),
      );

      if (response.statusCode == 200 ) {
        final responseData = jsonDecode(response.body);

        final String token = responseData['access_token'] ?? 'Sin asignar';
          if(token != 'Sin asignar') {
            final String roles = responseData['roles'] ?? 'Sin asignar';
            final String userid = responseData['userid'] ?? 'Sin asignar';
            final String names = responseData['names'] ?? 'Sin asignar';
            final String lastName = responseData['lastNames'] ?? 'Sin asignar';
            final String mail = responseData['mail'] ?? 'Sin asignar';
            final String phone_number = responseData['phone_number'] ??
                'Sin asignar';
            final String relationshipWithTheUniversity = responseData['relationshipWithTheUniversity'] ??
                'Sin asignar';


            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('jwt_token', token);
            if (roles == 'upb_community_accounts') {
              await prefs.setString('roles', 'Comunidad UPB');
            }
            if (roles == 'prehospital_care_accounts') {
              await prefs.setString('roles', 'APH');
            }
            await prefs.setString(
                'relationshipWithTheUniversity', relationshipWithTheUniversity);
            await prefs.setString('roles_partition_key', roles);
            await prefs.setString('userid', userid);
            await prefs.setString('names', names);
            await prefs.setString('lastNames', lastName);
            await prefs.setString('mail', mail);
            await prefs.setString('phone_number', phone_number);


            final webSocketService = WebSocketService();
            await webSocketService.connect();

            if (responseData['roles'] == 'prehospital_care_accounts') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => APHHomeScreen()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BrigaHomescreen()),
              );
            }

            firstNameController.clear();
            lastNameController.clear();
            emailController.clear();
            passwordController.clear();
            phoneController.clear();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registro exitoso')),

            );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('La cuenta ya existe')),
            );
          }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en el registro: ${response.body}')),
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
      backgroundColor: basilTheme?.surface,
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
                Image.asset('assets/Logo_UPB.png', height: 150),
                const SizedBox(height: 30),
                Text(
                  'Regístrese',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: basilTheme?.onSurface),
                ),
                const SizedBox(height: 30),
                Box(
                  topLabel: 'Nombres',
                  bottomHelperText: '',
                  inputType: TextInputType.name,
                  controller: firstNameController,
                ),
                Box(
                  topLabel: 'Apellidos',
                  bottomHelperText: '',
                  controller: lastNameController,
                  inputType: TextInputType.name,
                ),
                Box(
                  topLabel: 'Correo institucional',
                  bottomHelperText: 'Ingresa tu correo institucional de preferencia',
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                Box(
                  topLabel: 'Número de celular',
                  bottomHelperText: 'Ingresa tu número de celular',
                  controller: phoneController,
                  inputType: TextInputType.phone,
                ),
                BuildDropdownField<RelationshipWithTheUniversity>(
                    topLabel: 'Relación con la universidad',
                    bottomHelperText: '',
                    items: RelationshipWithTheUniversity.values,
                    controller: relationshipWithTheUniversityController
                ),
                const SizedBox(height: 10),
                Boxispassword(
                  topLabel: 'Contraseña',
                  bottomHelperText: 'Ingresa tu contraseña',
                  controller: passwordController,
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                Center(
                  child: Button(
                    text: 'Registrarme',
                    width: 133,
                    onClick: () => registerUser(context),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: CustonOutlinedButton(
                    text: 'Volver',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    width: 206,
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