import 'package:appv2/APH/CustonBottomNavigationBar.dart';
import 'package:appv2/APH/Informes.dart';
import 'package:appv2/Components/Box.dart';
import 'package:appv2/Components/Button.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Components/buildDropdownField.dart';
import 'package:appv2/Components/enums.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/websocket_service.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MiPerfil.dart';


class APHInformePendienteScreen extends StatefulWidget {
  final Map<String, dynamic> report;

  APHInformePendienteScreen({required this.report});

  @override
  _APHInformePendienteScreenState createState() => _APHInformePendienteScreenState();
}

class _APHInformePendienteScreenState extends State<APHInformePendienteScreen> {
  bool followUpChecked = false; // Estado del checkbox
  bool secureLiteUpChecked = false;
  final WebSocketService _webSocketService = WebSocketService();
  final TextEditingController hourArriveController = TextEditingController();
  //patient
  final TextEditingController namesController = TextEditingController();
  final TextEditingController lastNamesController = TextEditingController();
  final TextEditingController typeDocumentController = TextEditingController();
  final TextEditingController numberOfDocumentController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController relationshipWithTheUniversityController = TextEditingController();
  //contact
  final TextEditingController attentionForSecureLineController = TextEditingController();
  final TextEditingController meansOfAttentionController = TextEditingController();
  final TextEditingController startedInformationController = TextEditingController();
  //evaluation
  final TextEditingController reasonForConsultationController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController physicalExamController = TextEditingController();
  final TextEditingController recordController = TextEditingController();
  final TextEditingController sentToController = TextEditingController();
  final TextEditingController diagnosticImpressionController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
  final TextEditingController followUpController = TextEditingController();
  //attendnt
  final TextEditingController callHourController = TextEditingController();
  final TextEditingController callAttendntNameController = TextEditingController();
  //equipment
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  //noteForFollowUp
  final TextEditingController noteForFollowUpController = TextEditingController();




  @override
  void dispose() {
    hourArriveController.dispose();
    namesController.dispose();
    lastNamesController.dispose();
    typeDocumentController.dispose();
    numberOfDocumentController.dispose();
    genderController.dispose();
    ageController.dispose();
    relationshipWithTheUniversityController.dispose();
    attentionForSecureLineController.dispose();
    meansOfAttentionController.dispose();
    startedInformationController.dispose();
    reasonForConsultationController.dispose();
    diseaseController.dispose();
    physicalExamController.dispose();
    recordController.dispose();
    sentToController.dispose();
    diagnosticImpressionController.dispose();
    treatmentController.dispose();
    followUpController.dispose();
    callHourController.dispose();
    callAttendntNameController.dispose();
    quantityController.dispose();
    typeController.dispose();
    sourceController.dispose();
    noteForFollowUpController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        callHourController.text = pickedTime.format(context);
      });
    }
  }
  Future<void> _selectTime_2(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        hourArriveController.text = pickedTime.format(context);
      });
    }
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
        "on_the_way": "false",
        "patient": {
          "names": namesController.text,
          "lastNames": lastNamesController.text,
          "typeDocument": typeDocumentController.text,
          "numberOfDocument": numberOfDocumentController.text,
          "gender": genderController.text,
          "age": ageController.text,
          "relationshipWithTheUniversity": relationshipWithTheUniversityController.text
        },
        "contact": {
          "attentionForSecureLine": attentionForSecureLineController.text,
          "meansOfAttention": meansOfAttentionController.text,
          "startedInformation": startedInformationController.text
        },
        "evaluation": {
          "reasonForConsultation": reasonForConsultationController.text,
          "disease": diseaseController.text,
          "physicalExam": physicalExamController.text,
          "record": "",
          "sentTo": sentToController.text,
          "diagnosticImpression": diagnosticImpressionController.text,
          "treatment": treatmentController.text,
          "followUp": followUpChecked // Guardar el valor del checkbox
        },
        "attendnt": {
          "callHour": callHourController.text,
          "callAttendntName": callAttendntNameController.text
        },
        "equipment": {
          "quantity": quantityController.text,
          "type": typeController.text,
          "source": sourceController.text
        },
        "noteForFollowUp": noteForFollowUpController.text
      };

      _webSocketService.closeReport(reportData, (String confirmationMessage) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Informe cerrado y enviado con éxito.')),
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CustomBottomNavigation(initialIndex: 1)),
                (Route<dynamic> route) => false,
          );
        }
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No se encontró el ID de usuario. Intente nuevamente.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
      backgroundColor: basilTheme?.surface,
      appBar: const CustonAppbar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Container(
               padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informe',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(color: basilTheme?.onSurface),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.report['reporter']['names'] + widget.report['reporter']['lastNames']?? 'N/A',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: basilTheme?.onSurface),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.report['reporter']['relationshipWithTheUniversity'] ?? 'N/A',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Paciente',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            Box(
                topLabel: 'Nombres',
                bottomHelperText: '',
                controller: namesController,
                inputType: TextInputType.name
            ),
            Box(
                topLabel: 'Apellidos',
                bottomHelperText: '',
                controller: namesController,
                inputType: TextInputType.name
            ),
            BuildDropdownField<DocumetType>(
                topLabel: 'Tipo de documetno',
                bottomHelperText: '',
                items: DocumetType.values,
                controller: typeDocumentController
            ),
            Box(
                topLabel: 'Numero de documento',
                bottomHelperText: '',
                controller: numberOfDocumentController,
                inputType:  TextInputType.number
            ),
            BuildDropdownField<Gender>(
                topLabel: 'Genero',
                bottomHelperText: '',
                items: Gender.values,
                controller: genderController
            ),
            Box(
                topLabel: 'Edad',
                bottomHelperText: '',
                controller: ageController,
                inputType:  TextInputType.number
            ),
            BuildDropdownField<RelationshipWithTheUniversity>(
                topLabel: 'Relacion con la universidad',
                bottomHelperText: '',
                items: RelationshipWithTheUniversity.values,
                controller: relationshipWithTheUniversityController
            ),
            const SizedBox(height: 30),
            Text(
              'Contacto',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            BuildDropdownField<meansOfAttention>(
                topLabel: 'Medios de atencion',
                bottomHelperText: '',
                items: meansOfAttention.values,
                controller: meansOfAttentionController
            ),
            Box(
                topLabel: 'Informacion inicial',
                bottomHelperText: '',
                controller: startedInformationController,
                inputType:  TextInputType.text
            ),
            Row(
              children: [
                Checkbox(
                  value: secureLiteUpChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      secureLiteUpChecked = newValue ?? false;
                    });
                  },
                ),
                Text(
                  "Linea segura",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: basilTheme?.onSurface),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Evaluacion',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => _selectTime_2(context),
              child: AbsorbPointer(
                child: Box(
                  topLabel: 'Hora de llegada del APH',
                  bottomHelperText: '',
                  controller: hourArriveController,
                  inputType: TextInputType.text,
                ),
              ),
            ),
            Box(
                topLabel: 'Rason de la consulta',
                bottomHelperText: '',
                controller: reasonForConsultationController,
                inputType:  TextInputType.text
            ),
            Box(
                topLabel: 'Enfermedad',
                bottomHelperText: '',
                controller: diseaseController,
                inputType:  TextInputType.text
            ),
            Box(
                topLabel: 'Examen fisico',
                bottomHelperText: '',
                controller: physicalExamController,
                inputType:  TextInputType.text
            ),
            Box(
                topLabel: 'Antecedentes personales',
                bottomHelperText: '',
                controller: recordController,
                inputType:  TextInputType.text
            ),
            Box(
                topLabel: 'Remitido A',
                bottomHelperText: '',
                controller: sentToController,
                inputType:  TextInputType.text
            ),
            Box(
                topLabel: 'Impresion diagnostica',
                bottomHelperText: '',
                controller: diagnosticImpressionController,
                inputType:  TextInputType.text
            ),
            Box(
                topLabel: 'Tratamiento',
                bottomHelperText: '',
                controller: treatmentController,
                inputType:  TextInputType.text
            ),
            Row(
              children: [
                Checkbox(
                  value: followUpChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      followUpChecked = newValue ?? false;
                    });
                  },
                ),
                Text(
                  "Requiere seguimiento",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: basilTheme?.onSurface),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Acudiente',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: Box(
                  topLabel: 'Hora de la llamada',
                  bottomHelperText: '',
                  controller: callHourController,
                  inputType: TextInputType.text,
                ),
              ),
            ),
            Box(
                topLabel: 'Nombre del acudiente',
                bottomHelperText: '',
                controller: callAttendntNameController,
                inputType:  TextInputType.text
            ),
            const SizedBox(height: 30),
            Text(
              'Equipamiento',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            Card(
              color: basilTheme?.primaryContainer,
            elevation: 3,
            child: Padding(

              padding:  const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Box(
                      topLabel: 'Cantidad',
                      bottomHelperText: '',
                      controller: quantityController,
                      inputType:  TextInputType.text
                  ),
                  BuildDropdownField<EquipmentType>(
                      topLabel: 'Tipo',
                      bottomHelperText: '',
                      items: EquipmentType.values,
                      controller: typeController
                  ),
                  BuildDropdownField<EquipmentSource>(
                      topLabel: 'Fuente del equipamiento',
                      bottomHelperText: '',
                      items: EquipmentSource.values,
                      controller: sourceController
                  ),
                ],
              ),
            ),
            ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(text: 'Cancelar',
                  width: 105,
                  onClick: () => Navigator.pop(context)
              ),
              Button(text: 'Completar',
                  width: 157,
                  onClick: () => _closeReport()
              ),
            ],
          )

          ],
        ),
      ),
    );
  }
}
