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
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPB Segura'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información personal',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
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
                      // Mostrar nombres y apellidos
                      Text(
                        '$names $lastName',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Mostrar tipo de usuario (role)
                      Text(
                        userRole,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isEditing = !_isEditing;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(_isEditing ? 'Cancelar' : 'Editar perfil', style: const TextStyle(color: Colors.black)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 134, 97, 83),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Información personal',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            buildInfoRow('Tipo de documento', 'Cédula de ciudadanía'),
            buildInfoRow('Número de documento', 'Campo sin asignar'),
            _isEditing ? buildEditableTextField('Número de teléfono', _telefonoController) : buildInfoRow('Número de teléfono', _telefonoController.text),
            _isEditing ? buildEditableTextField('Dirección residencial', _direccionController) : buildInfoRow('Dirección residencial', _direccionController.text),
            _isEditing ? buildEditableTextField('Contacto de emergencia', _contactoEmergenciaController) : buildInfoRow('Contacto de emergencia', _contactoEmergenciaController.text),
            buildInfoRow('Fecha de nacimiento', 'Campo sin asignar'),
            const SizedBox(height: 30),
            const Text(
              'Información médica',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            buildInfoRow('Tipo de sangre', 'Campo sin asignar'),
            _isEditing ? buildEditableTextField('Alergias', _alergiasController) : buildInfoRow('Alergias', _alergiasController.text),
            _isEditing ? buildEditableTextField('Medicamentos dependientes', _medicamentosController) : buildInfoRow('Medicamentos dependientes', _medicamentosController.text),
            _isEditing ? buildEditableTextField('Discapacidad', _discapacidadController) : buildInfoRow('Discapacidad', _discapacidadController.text),
            if (_isEditing) ...[
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                      // Guardar cambios (Opcional)
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 134, 97, 83),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: const Text(
                    'Guardar cambios',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget buildEditableTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 252, 228, 236),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}