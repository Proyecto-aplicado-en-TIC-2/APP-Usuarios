import 'package:flutter/material.dart';
import 'home.dart'; 

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();

  bool _isBrigadista = false;

  void _register() {
    if (_formKey.currentState!.validate()) {
      String userRole = _isBrigadista ? 'Brigadista' : 'Usuario normal';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso como $userRole')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(isBrigadista: _isBrigadista),
        ),
      );
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType inputType, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de cuenta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Image.asset('assets/images/escudo_login_bg.png', width: 150, height: 150),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField('Nombre de usuario', _usernameController, TextInputType.text, Icons.person),
                  _buildTextField('Número de teléfono', _phoneController, TextInputType.phone, Icons.phone),
                  _buildTextField('Número de documento', _documentController, TextInputType.number, Icons.credit_card),
                  _buildTextField('Contacto de emergencia', _emergencyContactController, TextInputType.phone, Icons.contact_phone),
                  _buildTextField('Tipo de sangre', _bloodTypeController, TextInputType.text, Icons.bloodtype),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _isBrigadista,
                        onChanged: (bool? value) {
                          setState(() {
                            _isBrigadista = value ?? false;
                          });
                        },
                      ),
                      const Text('¿Te gustaría ser brigadista?'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Registrar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


