import 'package:flutter/material.dart';
import 'ContactosEmergencia.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(child: Text('UPB SEGURA')), 
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 80, 
              child: DrawerHeader(
                child: Center( 
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                )
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
      ),

      body: Column( 
        children: [
          Image.asset('assets/images/logoupb.png'),
          ElevatedButton(onPressed: (){
              print('Hola mundo');
          }, child: Text('Emergencia médica'),
          ),
          ElevatedButton(onPressed: (){
              print('Hola mundo');
          }, child: Text('Incendio'),
          ),
          ElevatedButton(onPressed: (){
              print('Hola mundo');
          }, child: Text('Accidente vehicular'),
          ),
        ],
        
      ),
    );
  }
}

