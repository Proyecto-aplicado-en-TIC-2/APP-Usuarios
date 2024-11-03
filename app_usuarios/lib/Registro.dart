import 'package:appv2/Components/Box.dart';
import 'package:appv2/Components/BoxIsPassword.dart';
import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CustonOutlinedButton.dart';
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

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  // Controladores para los campos de texto
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(); // Controlador para el número de celular

  Future<void> registerUser(BuildContext context) async {
    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String phone = phoneController.text.trim();

    // Validación básica
    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    final Uri url = Uri.parse(APIConstants.registerEndpoint);

    try {
      // Realizar la solicitud POST
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'password': password,
          'user': {
            'names': firstName,
            'last_names': lastName,
            'mail': email,
            'phone_number': phone, // Añade el número de celular al cuerpo de la solicitud
            'relationship_with_the_university': 'Student'
          },
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Almacena datos en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', responseData['access_token']);
        await prefs.setString('user_role', responseData['roles']);
        await prefs.setString('userid', responseData['userid']);
        await prefs.setString('names', responseData['names']);
        await prefs.setString('lastNames', responseData['lastNames']);

        // Conecta al WebSocket
        final webSocketService = WebSocketService();
        await webSocketService.connect();

        // Redirige a la pantalla correcta según el rol
        if (responseData['roles'] == 'prehospital_care_accounts') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => APHHomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  BrigaHomescreen()),
          );
        }

        // Limpiar campos después del registro
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        passwordController.clear();
        phoneController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en el registro: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en la conexión: $e')),
      );
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/Logo_UPB.png', height: 150),
                const SizedBox(height: 30),
                Text(
                  'Regístrese',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: basilTheme?.onSurface)
                ),
                const SizedBox(height: 30),
                Box(topLabel: 'Nombres',
                    bottomHelperText: '',
                  inputType: TextInputType.name,
                  controller: firstNameController,),
                Box(topLabel: 'Apellidos',
                    bottomHelperText: '',
                    controller: lastNameController,
                  inputType: TextInputType.name,),
                Box(topLabel: 'Correo institucional',
                    bottomHelperText: 'Ingresa tu correo institucional de preferencia',
                    controller: emailController,
                  inputType: TextInputType.emailAddress,),
                Box(topLabel: 'Número de celular',
                    bottomHelperText: 'Ingresa tu número de celular',
                    controller: phoneController,
                  inputType: TextInputType.phone,),
                Boxispassword(topLabel: 'Contraseña',
                    bottomHelperText: 'Ingresa tu contraseña',
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    isPassword: true,),
              const SizedBox(height: 10),
              Center(
                child: Button(
                  text: 'Registrarme',
                  width: 133,
                  onClick: () => registerUser(context),),
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