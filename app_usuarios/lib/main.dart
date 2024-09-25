import 'package:flutter/material.dart';
import 'ContactosEmergencia.dart'; // Asegúrate de tener esta vista creada

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ComunidadUPB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Widget para el AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: const Center(child: Text('UPB SEGURA')),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
    );
  }

  // Widget para el Drawer
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
            leading: const Icon(Icons.home),
            title: const Text('Reportar emergencia'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Contactos de emergencia'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Información personal'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // Widget para el contenido del body
  Widget _buildBody() {
    return Column(
      children: [
        Container(
           decoration: BoxDecoration( 
              border: Border.all(color: Colors.red, width: 2),
          ),
          margin: EdgeInsets.only(top: 0),
          child: Center(
            child:Image.asset('assets/images/logoupb.png') ,
          ),
        ),
        
        Center(
          child: Text('¿Qué sucede?')
        ),
        SizedBox(height:10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFFA13F91),
            padding: EdgeInsets.symmetric(horizontal: 80,vertical: 20),
            textStyle: TextStyle(fontSize: 20)
          ),
          onPressed: () {
            print('Hola mundo');
          },
          child: Text('Emergencia médica'),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFFFB054B),
            padding: EdgeInsets.symmetric(horizontal: 60,vertical: 20),
            textStyle: TextStyle(fontSize: 20)
          ),
          onPressed: () {
            print('Hola mundo');
          },
          child: Text('Emergencia de Incendio'),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFFA70744),
            padding: EdgeInsets.symmetric(horizontal: 80,vertical: 20),
            textStyle: TextStyle(fontSize: 20)
          ),
          onPressed: () {
            print('Hola mundo');
          },
          child: Text('Accidente vehicular'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(), // Usar el widget del AppBar
      drawer: _buildDrawer(), // Usar el widget del Drawer
      body: _buildBody(), // Usar el widget del body
    );
  }
}

