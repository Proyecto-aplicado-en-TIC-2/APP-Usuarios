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
            SizedBox(height: 50),
            const Text('¿Tienes una emergencia?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200)),
            const SizedBox(height: 30),
            const Text('Pulse el botón para comunicarte con la\n            línea de atención deseada', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 30), 
           
            //--------------b1
            ElevatedButton( 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFA13F91),
                padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 70), 
                textStyle: const TextStyle(fontSize: 20)
              ),
              onPressed: () {
                  
              },
              child: Row( 
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone), 
                  SizedBox(width: 8), 
                  const Text('Línea \nUPB'),
                ],
              ),
            ),
            const SizedBox(height: 30), 
            //----------b2
            ElevatedButton( 
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFD92427),
                padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 70), 
                textStyle: const TextStyle(fontSize: 20)
              ),
              onPressed: () {
                
              },
              child: Row( 
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_in_talk), 
                  SizedBox(width: 8), 
                  const Text('Línea \nnacional', style: TextStyle(fontSize: 25)),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}