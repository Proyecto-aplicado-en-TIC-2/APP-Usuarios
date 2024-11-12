import 'package:appv2/APH/CustonBottomNavigationBar.dart';
import 'package:appv2/Components/Box.dart';
import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Components/CustonOutlinedButton.dart';
import 'package:appv2/Components/buildDropdownField.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/websocket_service.dart';
import 'package:appv2/Brigadistas/BrigaHome.dart';
import 'package:flutter/material.dart';
import 'package:appv2/Components/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UbicacionMediaprioridadScreen extends StatefulWidget {
  final String priority;
  const UbicacionMediaprioridadScreen({
    Key? key,
    required this.priority,
  }) : super(key: key);

  @override
  _UbicacionMediaprioridadScreenState createState() => _UbicacionMediaprioridadScreenState();
}

class _UbicacionMediaprioridadScreenState extends State<UbicacionMediaprioridadScreen> {
  final TextEditingController blockController = TextEditingController();
  final TextEditingController classroomController = TextEditingController();
  final TextEditingController pointOfReferenceController = TextEditingController();
  final TextEditingController whatIsHappeningController = TextEditingController();
  final WebSocketService _webSocketService = WebSocketService();
  bool isLoading = false;

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
    whatIsHappeningController.dispose();

    super.dispose();
  }

  void sendReport(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    try {
      print('isLoading: $isLoading');
      final reportData = {
        'whatIsHappening': whatIsHappeningController.text,
        "affected": "null",
        "partition_key": "Medico",
        "priority": widget.priority,
        "location": {
          "block": blockController.text,
          "classroom": classroomController.text.isNotEmpty ? int.parse(
              classroomController.text) : null,
          "pointOfReference": pointOfReferenceController.text
        }
      };

      _webSocketService.sendReport(reportData, (String serverResponse) async {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(serverResponse))
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? roles =  prefs.getString('roles_partition_key');
        print(roles);
        if(roles == 'prehospital_care_accounts') {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CustomBottomNavigation(initialIndex: 0)),
                (Route<dynamic> route) => false,
          );
        }else{
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const BrigaHomescreen()),
                  (Route<dynamic> route) => false,
          );
        }
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Algo salio mal, pero no eres tu: $e')),
      );
    }finally{
    }
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
      appBar: const CustonAppbar(automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        BuildDropdownField<Block>(
                          topLabel: 'Bloque o referencia en la que estás ubicado',
                          bottomHelperText: 'Ejemplos: Bloque 2, Biblioteca, Cafetería, etc.',
                          items: Block.values,
                          controller: blockController,
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
                          topLabel: 'Punto de referencia',
                          bottomHelperText: 'Descripción breve',
                          controller: pointOfReferenceController,
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(height: 30),
                        Box(
                          topLabel: '¿Describe lo que te está pasando?',
                          bottomHelperText: 'Descripción breve',
                          controller: whatIsHappeningController,
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
                              onClick: ()   =>  sendReport(context)
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'Recomendación',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: basilTheme?.onSurface),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Puedes asistir a una de las estaciones que están ubicadas en la universidad, para brindarte ayuda',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: basilTheme?.onSurface),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}