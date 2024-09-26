import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slide Menu Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Center(child: Text('UPB SEGURA')),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: const Drawer(
        // ... (el código del Drawer se mantiene igual)
      ),
      body: Column( 
        children: [
          Center( // Envolver la imagen en un Center para centrarla
            child: Image.asset(
              'assets/images/logoupb.png',
              width: MediaQuery.of(context).size.width / 3.0,
              height: MediaQuery.of(context).size.height / 5.0,
            ),
          ),
          const Center(
            child: Text('Contenido principal'),
          ),
        ],
      ),
    );
  }
}
