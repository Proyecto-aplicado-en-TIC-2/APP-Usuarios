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


class SeeHistoryReportDetails extends StatefulWidget {
  final Map<String, dynamic> report;

  SeeHistoryReportDetails({required this.report});

  @override
  _SeeHistoryReportDetailsState createState() => _SeeHistoryReportDetailsState();
}

class _SeeHistoryReportDetailsState extends State<SeeHistoryReportDetails> {

  @override
  void initState() {
    super.initState();
    print(widget.report);
  }

  @override
  void dispose() {
    super.dispose();
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
                    widget.report['reporter']['names'] ?? 'N/A' + widget.report['reporter']['lastNames'] ?? 'N/A',
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
            buildInfoRow(
                'Nombres',
                widget.report['patient']['names']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Apellidos',
                widget.report['patient']['lastNames']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Tipo de documetno',
                widget.report['patient']['typeDocument']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Numero de documento',
                widget.report['patient']['numberOfDocument']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Genero',
                widget.report['patient']['gender'] ?? 'N/A',
                context
            ),
            buildInfoRow(
                'Edad',
                widget.report['patient']['age']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Relacion con la universidad',
                widget.report['patient']['relationshipWithTheUniversity']?? 'N/A',
                context
            ),
            const SizedBox(height: 30),
            Text(
              'Contacto',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            buildInfoRow(
                'Contacto por linea segura',
                widget.report['contact']['attentionForSecureLine'].toString(),
                context
            ),
            buildInfoRow(
                'Medios de atencion',
                widget.report['contact']['meansOfAttention']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Informacion inicial',
                widget.report['contact']['startedInformation']?? 'N/A',
                context
            ),
            const SizedBox(height: 30),
            Text(
              'Evaluacion',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            buildInfoRow(
                'Rason de la consulta',
                widget.report['evaluation']['reasonForConsultation']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Enfermedad',
                widget.report['evaluation']['disease']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Examen fisico',
                widget.report['evaluation']['physicalExam']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Antecedentes personales',
                widget.report['evaluation']['record']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Remitido A',
                widget.report['evaluation']['sentTo']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Impresion diagnostica',
                widget.report['evaluation']['diagnosticImpression']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Tratamiento',
                widget.report['evaluation']['treatment']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Seguimiento',
                widget.report['evaluation']['followUp'].toString(),
                context
            ),

            const SizedBox(height: 30),
            Text(
              'Acudiente',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),
            buildInfoRow(
                'Hora de la llamada',
                widget.report['attendnt']['callHour']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Nombre del acudiente',
                widget.report['attendnt']['callAttendntName']?? 'N/A',
                context
            ),
            const SizedBox(height: 30),
            Text(
              'Equipamiento',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 30),

            buildInfoRow(
                'Cantidad',
                widget.report['equipment']['quantity']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Tipo',
                widget.report['equipment']['type']?? 'N/A',
                context
            ),
            buildInfoRow(
                'Fuente del equipamiento',
                widget.report['equipment']['source']?? 'N/A',
                context
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(text: 'Volver',
                    width: 105,
                    onClick: () => Navigator.pop(context)
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}

Widget buildInfoRow(String title, String value, BuildContext context) {
  final basilTheme = Theme.of(context).extension<BasilTheme>();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:  Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
        ),
        Text(
          value,
          style:  Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
        )
      ],
    ),
  );
}

