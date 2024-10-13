import 'package:flutter/material.dart';
import 'ContactosEmergencia.dart';

class Infopersonal extends StatefulWidget {
  const Infopersonal({super.key});

  @override
  _InfopersonalState createState() => _InfopersonalState();
}

class _InfopersonalState extends State<Infopersonal> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controladores de texto
  final TextEditingController _nameController = TextEditingController(text: 'Nombre de usuario');
  final TextEditingController _phoneController = TextEditingController(text: '21032103233');
  final TextEditingController _documentController = TextEditingController(text: '11212312');
  final TextEditingController _emergencyContactController = TextEditingController(text: '3123123321');
  final TextEditingController _bloodTypeController = TextEditingController(text: 'A+');

  // Variable para controlar el modo edición
  bool _isEditing = false;

  // Drawer con las opciones
  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 90,
            child: DrawerHeader(
              child: Center(
                child: Text(
                  'Bienvenido',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.warning),
            title: const Text('Reportar emergencia'),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: const Text('Contactos de emergencia'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactosEmergencia()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Información personal'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // Widget para mostrar campos de perfil
  Widget _buildProfileItem(IconData icon, String label, TextEditingController controller) {
    return Row(
      children: [
        Icon(icon, size: 40),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                
              ),
              _isEditing
                  ? TextFormField(
                      controller: controller,
                      style: const TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 2), // Reduce el padding vertical
                      isDense: true, 
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    )
                  : Text(
                      controller.text,
                      style: const TextStyle(fontSize: 18),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  // Método para actualizar la información
  void _saveChanges() {
    setState(() {
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('La información fue actualizada correctamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Información personal'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          _isEditing
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView( // Hacer la vista desplazable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Icono de perfil
            const Center(
              child: Icon(Icons.account_circle, size: 100, color: Colors.black),
            ),
            const SizedBox(height: 10),
            // Nombre del usuario
            const Center(
              child: Text('Nombre de usuario', style: TextStyle(fontSize: 22)),
            ),
            const SizedBox(height: 30),
            // Información del perfil
            _buildProfileItem(Icons.person, 'Nombre', _nameController),
            const SizedBox(height: 20),
            _buildProfileItem(Icons.phone, 'Número de teléfono', _phoneController),
            const SizedBox(height: 20),
            _buildProfileItem(Icons.credit_card, 'Número de documento', _documentController),
            const SizedBox(height: 20),
            _buildProfileItem(Icons.contact_phone, 'Contacto de emergencia', _emergencyContactController),
            const SizedBox(height: 20),
            _buildProfileItem(Icons.bloodtype, 'Tipo de sangre', _bloodTypeController),
            const SizedBox(height: 30),

            
            if (_isEditing)
              Center(
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                    backgroundColor: const Color(0xFFA70744),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Guardar cambios'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


