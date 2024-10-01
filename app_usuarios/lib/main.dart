import 'package:flutter/material.dart';
import 'ContactosEmergencia.dart';
import 'InfoPersonal.dart';


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
            selected: true,
            selectedTileColor: Colors.blue[100],
            leading:  Image.asset('assets/icons/sos.png', height: 25, width: 25),
            title: const Text('Reportar emergencia'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/phonenew.png', height: 25, width: 25),
            title: const Text('Contactos de emergencia'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactosEmergencia()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Información personal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Infopersonal()),
              );
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
           
          margin: const EdgeInsets.only(top: 0),
          child: Center(
            child:Image.asset('assets/images/logoupb_.png', width: 350, height: 250)
          ),
        ),
        
        const Center(
          child: Text('¿Qué sucede?',
          style: TextStyle(fontSize: 24))
        ),
        const SizedBox(height:20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFA13F91),
            padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 20),
            textStyle: const TextStyle(fontSize: 20)
          ),
          onPressed: () {
            print('Hola mundo');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/icon_botiquin.png', height: 40, width: 40,),
              const SizedBox(width: 18),
              const Text('Emergencia médica'),
            ],
          ),
          
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFFB054B),
            padding: const EdgeInsets.symmetric(horizontal: 42,vertical: 20),
            textStyle: const TextStyle(fontSize: 20)
          ),
          onPressed: () {
            print('Hola mundo');
          },
           child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/icon_fire.png', height: 40, width: 40,),
              const SizedBox(width: 18),
              const Text('Emergencia de incendio'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFA70744),
            padding: const EdgeInsets.symmetric(horizontal:57,vertical: 20),
            textStyle: const TextStyle(fontSize: 20)
          ),
          onPressed: () {
            print('Hola mundo');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/icon_accidentevehicular.png', height: 40, width: 40,),
              const SizedBox(width: 28),
              const Text('Accidente vehicular'),
            ],
          ),
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

