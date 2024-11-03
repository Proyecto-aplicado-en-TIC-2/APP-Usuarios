import 'package:appv2/Components/Box.dart';
import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Components/CustonOutlinedButton.dart';
import 'package:appv2/Constants/AppColors.dart';
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

      // Usa Navigator para limpiar la pila y redirigir a BrigaHomescreen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const BrigaHomescreen()),
            (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
      appBar: const CustonAppbar(automaticallyImplyLeading: true),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding:  const EdgeInsets.all(5),
              child: Text(
                '¿Donde estas ubicado?',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: basilTheme?.onSurface),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              color: basilTheme?.primaryContainer,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20), // Ajusta el padding como desees
                child: Column(
                  children: [
                    Box(
                      topLabel: 'Bloque o referencia en la que estás ubicado',
                      bottomHelperText: 'Ejemplos: Bloque 2, Biblioteca, Cafetería, etc.',
                      controller: blockController,
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 30),
                    Box(
                      topLabel: 'Número de aula',
                      bottomHelperText: 'Puedes dejarlo en blanco',
                      controller: classroomController,
                      inputType: TextInputType.number,
                    ),
                    const SizedBox(height: 30),
                    Box(
                      topLabel: '¿Describe lo que te está pasando?',
                      bottomHelperText: 'Descripción breve',
                      controller: pointOfReferenceController,
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustonOutlinedButton(
                          text: 'Cancelar',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          width: 105,
                        ),
                        Button(
                          text: 'Enviar',
                          width: 88,
                          onClick: () {
                            sendReport(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding:  const EdgeInsets.all(5),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text( 'Recomendación',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: basilTheme?.onSurface),
                  ),
                  const SizedBox(height: 10),
                  Text( 'Puedes asistir a una de las estaciones que están ubicadas en la universidad, para bridarte ayuda',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: basilTheme?.onSurface),
                  ),
                ],
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}