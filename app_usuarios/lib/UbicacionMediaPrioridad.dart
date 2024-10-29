import 'package:appv2/MiPerfil.dart';
import 'package:appv2/websocket_service.dart';
import 'package:appv2/Brigadistas/BrigaHome.dart'; // Asegúrate de importar la pantalla de destino
import 'package:flutter/material.dart';

class UbicacionMediaprioridadScreen extends StatefulWidget {
  const UbicacionMediaprioridadScreen({super.key});

  @override
  _UbicacionMediaprioridadScreenState createState() => _UbicacionMediaprioridadScreenState();
}

class _UbicacionMediaprioridadScreenState extends State<UbicacionMediaprioridadScreen> {
  final TextEditingController blockController = TextEditingController();
  final TextEditingController classroomController = TextEditingController();
  final TextEditingController pointOfReferenceController = TextEditingController();
  final WebSocketService _webSocketService = WebSocketService(); // Instancia del servicio WebSocket

  @override
  void initState() {
    super.initState();
    _webSocketService.connect();
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    blockController.dispose();
    classroomController.dispose();
    pointOfReferenceController.dispose();
    super.dispose();
  }

  void sendReport(BuildContext context) {
    final reportData = {
      "partition_key": "Medico",
      "priority": "Media",
      "location": {
        "block": blockController.text,
        "classroom": classroomController.text.isNotEmpty ? int.parse(classroomController.text) : null,
        "pointOfReference": pointOfReferenceController.text
      }
    };

    // Llama al método sendReport y maneja la respuesta
    _webSocketService.sendReport(reportData, (String serverResponse) {
      // Muestra el pop-up con la respuesta del servidor
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(serverResponse))
      );

      // Redirige a la pantalla BrigaHomescreen después de enviar el informe
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BrigaHomescreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPB Segura'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MiPerfilScreen(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Dónde estás ubicado?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bloque o referencia en la que estás ubicado',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: blockController,
                      decoration: InputDecoration(
                        hintText: 'Ejemplos: Bloque 2, Biblioteca, Cafetería, Gimnasio y etc.',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Número de aula',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: classroomController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Puedes dejarlo en blanco',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '¿Describe lo que te está pasando?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: pointOfReferenceController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Descripción breve',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffffffff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            sendReport(context); // Llama a sendReport con el contexto
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8A1F1F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text(
                            'Enviar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}