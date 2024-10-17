import 'package:flutter/material.dart';

class RegistrarHorasPage extends StatefulWidget {
  const RegistrarHorasPage({super.key});

  @override
  _RegistrarHorasPageState createState() => _RegistrarHorasPageState();
}

class _RegistrarHorasPageState extends State<RegistrarHorasPage> {
  // Datos iniciales de las horas disponibles por día en los Cards  (Estos datos son estáticos)
  Map<String, List<String>> availableHours = {
    'Lunes': ['8:00 AM - 10:00 AM', '8:00 AM - 10:00 AM', '8:00 AM - 10:00 AM'],
    'Martes': ['8:00 AM - 10:00 AM'],
    'Miércoles': ['8:00 AM - 10:00 AM'],
    'Jueves': ['8:00 AM - 10:00 AM'],
    'Viernes': ['8:00 AM - 10:00 AM'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horas disponibles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Icono del reloj
            const Center(
              child: Icon(
                Icons.access_time_rounded,
                size: 100,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),

            _buildDayCard(context, 'Lunes'),
            const SizedBox(height: 10),
            _buildDayCard(context, 'Martes'),
            const SizedBox(height: 10),
            _buildDayCard(context, 'Miércoles'),
            const SizedBox(height: 10),
            _buildDayCard(context, 'Jueves'),
            const SizedBox(height: 10),
            _buildDayCard(context, 'Viernes'),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(BuildContext context, String day) {
    return GestureDetector(
      onTap: () {
        _showEditPopup(context, day); 
      },
      child: SizedBox(
        width: double.infinity,  
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.black12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: availableHours[day]!.map((hour) => Text(hour, style: const TextStyle(color: Colors.grey))).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _showEditPopup(BuildContext context, String day) {
    List<String> localHours = List.from(availableHours[day]!);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.all(16.0),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        day,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            availableHours[day] = localHours; 
                          });
                          Navigator.pop(context); 
                        },
                        child: const Icon(Icons.close, size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  if (localHours.isNotEmpty)
                    ...localHours.map((hour) => _buildEditableSlot('Franja horaria', hour)).toList()
                  else
                    const Center(
                      child: Text(
                        'No disponible',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Acción para hacer el día "No disponible"
                          setState(() {
                            localHours.clear();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        child: const Text('No disponible'),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            localHours.add(''); 
                          });
                        },
                        icon: const Icon(Icons.add, size: 24),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEditableSlot(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: value,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Introduce la hora',
          ),
        ),
      ],
    );
  }
}




