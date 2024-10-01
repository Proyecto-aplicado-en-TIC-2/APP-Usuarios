import 'package:flutter/material.dart';
import 'main.dart'; // Importar main.dart;

class Infopersonal extends StatefulWidget {
  const Infopersonal({super.key});

  @override
  _InfopersonalState createState() => _InfopersonalState();
}

class _InfopersonalState extends State<Infopersonal> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Widget para el Drawer (copiado de _MyHomePageState)
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
            selected: true, 
            selectedTileColor: Colors.blue[100], 
            leading: const Icon(Icons.warning), 
            title: const Text('Reportar emergencia'),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst); 
            },
          ),
          ListTile(
            selected: true,
            selectedTileColor: Colors.green[100], 
            leading: const Icon(Icons.contact_phone), 
            title: const Text('Contactos de emergencia'),
            onTap: () {
              Navigator.pop(context); 
            },
          ),
          ListTile(
            selected: true,
            selectedTileColor: Colors.orange[100], 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Agregar la clave al Scaffold
      appBar: AppBar(
        title: Text('Información personal'),
        leading: IconButton( 
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: _buildDrawer(), 
      body: Center(
        child: Text('Contenido de la vista de Información personal'),
      ),
    );
  }
}