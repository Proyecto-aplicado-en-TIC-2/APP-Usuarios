import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Components/CustonOutlinedButton.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class MiPerfilScreen extends StatefulWidget {
  const MiPerfilScreen({super.key});

  @override
  _MiPerfilScreenState createState() => _MiPerfilScreenState();
}

class _MiPerfilScreenState extends State<MiPerfilScreen> {
  bool _isEditing = false;

  // Controladores para los campos de texto
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _direccionController = TextEditingController(text: 'Campo sin asignar');
  TextEditingController _contactoEmergenciaController = TextEditingController(text: 'Campo sin asignar');
  TextEditingController _discapacidadController = TextEditingController(text: 'Campo sin asignar');
  TextEditingController _medicamentosController = TextEditingController(text: 'Campo sin asignar');
  TextEditingController _alergiasController = TextEditingController(text: 'Campo sin asignar');

  // Campos que se llenarán desde SharedPreferences
  String userRole = "Campo sin asignar";
  String userId = "Campo sin asignar";
  String names = "Campo sin asignar";
  String lastName = "Campo sin asignar";
  String phone = "Campo sin asignar"; // Valor inicial predeterminado

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Cargar los datos del usuario al iniciar
  }

  // Cargar los datos almacenados en SharedPreferences
  Future<void> _loadUserData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
      userRole = prefs.getString('user_role') ?? 'Campo sin asignar';
      userId = prefs.getString('userid') ?? 'Campo sin asignar';
      names = prefs.getString('names') ?? 'Campo sin asignar';
      lastName = prefs.getString('lastNames') ?? 'Campo sin asignar';
      phone = prefs.getString('phone') ?? 'Campo sin asignar'; // Usar el valor predeterminado si no se encuentra
      _telefonoController.text = phone; // Inicializar el controlador con el valor del teléfono
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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: basilTheme?.onSurface),
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: basilTheme?.onSurface),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userRole,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
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
                const Button(text: 'Editar perfil',
                    width: 122,
                    onClick: ArgumentError.notNull
                ),
               CustonOutlinedButton(text: 'Cerrar sesión',
                    onPressed:  () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
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
                   style:  Theme.of(context).textTheme.headlineMedium?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Tipo de documentó',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('Cedula de ciudadanía',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Numero de documentó',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('18924038233',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Numero de teléfono',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('3008059938',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Dirección residencial',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('Barrio laureles Calle 43# 71-76',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Contacto de emergencia',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('3152001090',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Fecha de nacimiento ',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('11/03/2002',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 30),
                 Text('Información medica ',
                   style:  Theme.of(context).textTheme.headlineMedium?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Tipo de sangre',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('O+',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Alergias',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('NA',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Medicamentos dependientes',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('NA',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 const SizedBox(height: 10),
                 Text('Discapacidad',
                   style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                 ),
                 Text('NA',
                   style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
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