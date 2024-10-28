import 'package:flutter/material.dart';
import 'main.dart';

class MiPerfilScreen extends StatefulWidget {
  const MiPerfilScreen({super.key});

  @override
  _MiPerfilScreenState createState() => _MiPerfilScreenState();
}

class _MiPerfilScreenState extends State<MiPerfilScreen> {
  bool _isEditing = false;
  TextEditingController _telefonoController = TextEditingController(text: '3008059938');
  TextEditingController _direccionController = TextEditingController(text: 'Barrio laureles Calle 43# 71-76');
  TextEditingController _contactoEmergenciaController = TextEditingController(text: '3152001090');
  TextEditingController _discapacidadController = TextEditingController(text: 'NA');
  TextEditingController _medicamentosController = TextEditingController(text: 'NA');
  TextEditingController _alergiasController = TextEditingController(text: 'NA');

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
                      const Text(
                        'Nombre del usuario',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Tipo de usuario',
                        style: TextStyle(
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
                            MaterialPageRoute(builder: (context) => LoginScreen()),
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
            buildInfoRow('Número de documento', '18924038233'),
            _isEditing ? buildEditableTextField('Número de teléfono', _telefonoController) : buildInfoRow('Número de teléfono', _telefonoController.text),
            _isEditing ? buildEditableTextField('Dirección residencial', _direccionController) : buildInfoRow('Dirección residencial', _direccionController.text),
            _isEditing ? buildEditableTextField('Contacto de emergencia', _contactoEmergenciaController) : buildInfoRow('Contacto de emergencia', _contactoEmergenciaController.text),
            buildInfoRow('Fecha de nacimiento', '11/03/2002'),
            const SizedBox(height: 30),
            const Text(
              'Información médica',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            buildInfoRow('Tipo de sangre', 'O+'),
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
