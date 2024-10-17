import 'package:flutter/material.dart';
import 'ContactosEmergencia.dart';
import 'InfoPersonal.dart';
import 'Emer_incendio.dart';
import 'Emer_medica.dart';
import 'Emer_vehicular.dart';
import 'RegistrarHoras.dart';

class Home extends StatefulWidget {
  final bool isBrigadista; 

  const Home({super.key, required this.isBrigadista});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AppBar _buildAppBar() {
    return AppBar(
      title: const Center(child: Text('UPB SEGURA')),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
    );
  }

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
              Navigator.pop(context);
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
            leading: const Icon(Icons.info),
            title: const Text('Información personal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Infopersonal()),
              );
            },
          ),
          // Mostrar la opción de "Registrar horas" solo si el usuario es brigadista
          if (widget.isBrigadista)
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Registrar horas disponibles'),
              onTap: () {
                // Aquí navegas a la vista donde se registran las horas disponibles
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrarHorasPage()),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Center(
          child: Image.asset('assets/images/logoupb_.png', width: 350, height: 250),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            '¿Qué sucede?',
            style: TextStyle(fontSize: 24),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFA13F91),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmerMedica()),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/icon_botiquin.png', height: 40, width: 40),
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
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmerIncendio()),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/icon_fire.png', height: 40, width: 40),
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
            padding: const EdgeInsets.symmetric(horizontal: 57, vertical: 20),
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmerVehicular()),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/icon_accidentevehicular.png', height: 40, width: 40),
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
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }
}





