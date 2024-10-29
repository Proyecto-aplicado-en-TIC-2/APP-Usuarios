import 'package:flutter/material.dart';
import '../MiPerfil.dart';

enum Quadrant {
  Division1, Division2, Division3, Division4, Division5, Division6, Division7
}

enum Block {
  Block1, Block2, Block3, Block4, Block5, Block6, Block7, Block8, Block9, Block10, Block12, Block13,
  Block14, Block15, Block16, Block17, Block18, Block19, Block20, Block21, Block22, Block23, Block24,
  ComplejoDeIngenierias, Forum, BloquesExternosAlCampus
}

enum Gender { Male, Female, Otro }

enum EquipmentType {
  APOSITO_OCULAR, APOSITO_PQ, BAJALENGUA, BOLSAS_ROJAS, CATETER, ELECTRODOS, GUANTES_DE_LATEX,
LANCETA, TIRILLA, MACROGOTERO, SOL_SALINA, TAPABOCA, TORUNDA_DE_ALGODON, VENDA_DE_GASA_4_5YD,
VENDA_DE_GASA_5_5YD, VENDA_ELASTICA_4_5YD, VENDA_ELASTICA_5_5YD
}

enum EquipmentSource { Botiquin, Gabinete, TraumaPolideportivo }

enum Cases { Incendio, Medico, Estructural }

class APHInformePendienteScreen extends StatefulWidget {
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
            buildTextField('Salón', ''),
            buildTextField('Punto de referencia', ''),
            const SizedBox(height: 30),
            const Text(
              'Evaluación',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildTextField('Motivo de consulta', ''),
            buildTextField('Enfermedad', ''),
            buildTextField('Examen físico', ''),
            buildTextField('Enviado a', ''),
            buildTextField('Impresión diagnóstica', ''),
            buildTextField('Tratamiento', ''),
            const SizedBox(height: 10),
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
            buildDropdownField<Gender>(
              label: 'Género del Paciente',
              value: selectedGender,
              items: Gender.values,
              onChanged: (value) => setState(() => selectedGender = value),
            ),
            buildDropdownField<Cases>(
              label: 'Casos',
              value: selectedCase,
              items: Cases.values,
              onChanged: (value) => setState(() => selectedCase = value),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                ),
                const Text('Hacer seguimiento'),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 134, 97, 83),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text(
                  'Guardar cambios',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String placeholder, {int maxLines = 1, bool isReadOnly = false}) {
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