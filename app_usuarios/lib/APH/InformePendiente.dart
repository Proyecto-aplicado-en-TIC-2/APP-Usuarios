import 'package:appv2/APH/Informes.dart';
import 'package:appv2/websocket_service.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MiPerfil.dart';

enum Quadrant { Division1, Division2, Division3, Division4, Division5, Division6, Division7 }
enum Block { Block1, Block2, Block3, Block4, Block5, Block6, Block7, Block8, Block9, Block10, Block12, Block13, Block14, Block15, Block16, Block17, Block18, Block19, Block20, Block21, Block22, Block23, Block24, ComplejoDeIngenierias, Forum, BloquesExternosAlCampus }
enum Gender { Male, Female, Otro }
enum EquipmentType { APOSITO_OCULAR, APOSITO_PQ, BAJALENGUA, BOLSAS_ROJAS, CATETER, ELECTRODOS, GUANTES_DE_LATEX, LANCETA, TIRILLA, MACROGOTERO, SOL_SALINA, TAPABOCA, TORUNDA_DE_ALGODON, VENDA_DE_GASA_4_5YD, VENDA_DE_GASA_5_5YD, VENDA_ELASTICA_4_5YD, VENDA_ELASTICA_5_5YD }
enum EquipmentSource { Botiquin, Gabinete, TraumaPolideportivo }
enum Cases { Incendio, Medico, Estructural }

class APHInformePendienteScreen extends StatefulWidget {
  final Map<String, dynamic> report;

  APHInformePendienteScreen({required this.report});

  @override
  _APHInformePendienteScreenState createState() => _APHInformePendienteScreenState();
}

class _APHInformePendienteScreenState extends State<APHInformePendienteScreen> {
  Quadrant? selectedQuadrant;
  Block? selectedBlock;
  Gender? selectedGender;
  EquipmentType? selectedEquipmentType;
  EquipmentSource? selectedEquipmentSource;
  Cases? selectedCase;

  final TextEditingController classroomController = TextEditingController();
  final TextEditingController referencePointController = TextEditingController();
  final TextEditingController consultationReasonController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController physicalExamController = TextEditingController();
  final TextEditingController sentToController = TextEditingController();
  final TextEditingController diagnosticImpressionController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
  final TextEditingController hourArriveController = TextEditingController();
  final TextEditingController callHourController = TextEditingController();
  final TextEditingController callAttendntNameController = TextEditingController();
  final TextEditingController attentionForSecureLineController = TextEditingController();
  final TextEditingController meansOfAttentionController = TextEditingController();
  final TextEditingController startedInformationController = TextEditingController();
  final TextEditingController followUpController = TextEditingController();
  final TextEditingController noteForFollowUpController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    classroomController.dispose();
    referencePointController.dispose();
    consultationReasonController.dispose();
    diseaseController.dispose();
    physicalExamController.dispose();
    sentToController.dispose();
    diagnosticImpressionController.dispose();
    treatmentController.dispose();
    hourArriveController.dispose();
    callHourController.dispose();
    callAttendntNameController.dispose();
    attentionForSecureLineController.dispose();
    meansOfAttentionController.dispose();
    startedInformationController.dispose();
    followUpController.dispose();
    noteForFollowUpController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void _closeReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userid');
    if (userId != null) {
      Map<String, dynamic> reportData = {
        "help": {
          "user_id": userId,
          "case_id": widget.report['id'],
          "partition_key": widget.report['partition_key']
        },
        "hourArrive": hourArriveController.text,
        "close_case": "true",
        "classificationAttention": "",
        "patient": {
          "names": widget.report['reporter']['names'],
          "lastNames": widget.report['reporter']['lastNames'],
          "typeDocument": widget.report['reporter']['typeDocument'],
          "numberOfDocument": widget.report['reporter']['numberOfDocument'],
          "gender": selectedGender?.toString().split('.').last,
          "age": widget.report['reporter']['age'],
          "relationshipWithTheUniversity": widget.report['reporter']['relationshipWithTheUniversity']
        },
        "contact": {
          "attentionForSecureLine": attentionForSecureLineController.text,
          "meansOfAttention": meansOfAttentionController.text,
          "startedInformation": startedInformationController.text
        },
        "evaluation": {
          "reasonForConsultation": consultationReasonController.text,
          "disease": diseaseController.text,
          "physicalExam": physicalExamController.text,
          "record": "",
          "sentTo": sentToController.text,
          "diagnosticImpression": diagnosticImpressionController.text,
          "treatment": treatmentController.text,
          "followUp": followUpController.text
        },
        "attendnt": {
          "callHour": callHourController.text,
          "callAttendntName": callAttendntNameController.text
        },
        "equipment": {
          "quantity": int.tryParse(quantityController.text) ?? 0,
          "type": selectedEquipmentType?.toString().split('.').last,
          "source": selectedEquipmentSource?.toString().split('.').last
        },
        "noteForFollowUp": noteForFollowUpController.text
      };

      WebSocketService().closeReport(reportData, (String confirmationMessage) {
        // Muestra el SnackBar antes de redirigir a InformesScreen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Informe cerrado y enviado con éxito.')),
        );

        // Redirige a InformesScreen después de un breve retraso
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => InformesScreen()),
                (Route<dynamic> route) => false,
          );
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se encontró el ID de usuario. Intente nuevamente.")),
      );
    }
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
                MaterialPageRoute(builder: (context) => const MiPerfilScreen()),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informe',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildDropdownField<Quadrant>(
              label: 'Cuadrante',
              value: selectedQuadrant,
              items: Quadrant.values,
              onChanged: (value) => setState(() => selectedQuadrant = value),
            ),
            buildDropdownField<Block>(
              label: 'Bloque',
              value: selectedBlock,
              items: Block.values,
              onChanged: (value) => setState(() => selectedBlock = value),
            ),
            buildDropdownField<Gender>(
              label: 'Género del Paciente',
              value: selectedGender,
              items: Gender.values,
              onChanged: (value) => setState(() => selectedGender = value),
            ),
            buildDropdownField<EquipmentType>(
              label: 'Tipo de Equipo',
              value: selectedEquipmentType,
              items: EquipmentType.values,
              onChanged: (value) => setState(() => selectedEquipmentType = value),
            ),
            buildDropdownField<EquipmentSource>(
              label: 'Fuente de Equipo',
              value: selectedEquipmentSource,
              items: EquipmentSource.values,
              onChanged: (value) => setState(() => selectedEquipmentSource = value),
            ),
            buildDropdownField<Cases>(
              label: 'Caso',
              value: selectedCase,
              items: Cases.values,
              onChanged: (value) => setState(() => selectedCase = value),
            ),
            buildTextField('Hora de Llegada', 'HH:MM', controller: hourArriveController),
            buildTextField('Salón', '', controller: classroomController),
            buildTextField('Punto de referencia', '', controller: referencePointController),
            buildTextField('Motivo de consulta', '', controller: consultationReasonController),
            buildTextField('Enfermedad', '', controller: diseaseController),
            buildTextField('Examen físico', '', controller: physicalExamController),
            buildTextField('Enviado a', '', controller: sentToController),
            buildTextField('Impresión diagnóstica', '', controller: diagnosticImpressionController),
            buildTextField('Tratamiento', '', controller: treatmentController),
            buildTextField('Seguimiento', '', controller: followUpController),
            buildTextField('Hora de Llamada', 'HH:MM:SS', controller: callHourController),
            buildTextField('Nombre del Atendente', '', controller: callAttendntNameController),
            buildTextField('Atención por Línea Segura', '', controller: attentionForSecureLineController),
            buildTextField('Medios de Atención', '', controller: meansOfAttentionController),
            buildTextField('Información de Inicio', '', controller: startedInformationController),
            buildTextField('Cantidad de Equipo', '', controller: quantityController),
            buildTextField('Nota de Seguimiento', '', controller: noteForFollowUpController),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _closeReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 134, 97, 83),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text(
                  'Cerrar Reporte',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String placeholder, {int maxLines = 1, bool isReadOnly = false, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: placeholder,
              fillColor: const Color.fromARGB(255, 252, 228, 236),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownField<T>({
    required String label,
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<T>(
            value: value,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 252, 228, 236),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onChanged,
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString().split('.').last),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}