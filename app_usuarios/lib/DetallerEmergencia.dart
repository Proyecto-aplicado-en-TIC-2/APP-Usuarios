import 'package:flutter/material.dart';
import 'TiposAdicionalesEmergencia.dart';

class DetalleEmergenciaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('UPB Segura'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
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
              '¿Cuál es la emergencia?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tipo de emergencia',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.pink[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Incendio'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bloque o referencia en la que estas ubicado',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Ejemplos: Bloque 2, Biblioteca, Cafetería, Gimnasio y etc.',
                        fillColor: Colors.pink[100],
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
                      decoration: InputDecoration(
                        hintText: 'Puedes dejarlo en blanco',
                        fillColor: Colors.pink[100],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '¿Qué está pasando?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Descripción breve',
                        fillColor: Colors.pink[100],
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => OtrosTiposEmergenciaScreen(), 
                            ),
                    );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text('Enviar'),
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
