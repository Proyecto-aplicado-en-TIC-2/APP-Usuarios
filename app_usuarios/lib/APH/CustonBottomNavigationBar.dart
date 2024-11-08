import 'package:appv2/APH/Incidentes.dart';
import 'package:appv2/APH/Informes.dart';
import 'package:appv2/APH/aphome.dart';
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int initialIndex;

  const CustomBottomNavigation({
    Key? key,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  final List<Widget> screens = [
    APHHomeScreen(),
    APHIncidentesScreen(),
    InformesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();

    return Scaffold(
      appBar: const CustonAppbar(
          automaticallyImplyLeading: false
      ),
      body: screens[currentIndex], // Muestra la pantalla correspondiente al índice
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: basilTheme?.surfaceContainer,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_rounded),
            label: 'Incidentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_rounded),
            label: 'Informes',
          ),
        ],
      ),
    );
  }
}