import 'package:flutter/material.dart';
import 'InfoPersonal.dart';

class ContactosEmergencia extends StatefulWidget { 
  const ContactosEmergencia({super.key});

  @override
  _ContactosEmergenciaState createState() => _ContactosEmergenciaState();
}

class _ContactosEmergenciaState extends State<ContactosEmergencia> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Infopersonal()),
              ); 
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      appBar: AppBar(
        title: const Text('Contactos de Emergencia'),
        leading: IconButton( 
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: _buildDrawer(), 
      body: Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            const Text('Contenido de la vista de Información personal'),
            const SizedBox(height: 30), 
            //--------------b1
            ElevatedButton( 
              style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFFA13F91),
              padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 60),
              textStyle: const TextStyle(fontSize: 20)
            ),
              onPressed: () {
                // Acción al presionar el primer botón
              },
              child: const Text('Botón 1'),
            ),
            const SizedBox(height: 30), 
            //----------b2
            ElevatedButton( 
              style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFFA13F91),
              padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 60),
              textStyle: const TextStyle(fontSize: 20)
            ),
              onPressed: () {
                // Acción al presionar el segundo botón
              },
              child: const Text('Botón 2'),
            ),
          ],
        ),
      ),
    );
  }
}