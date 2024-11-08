import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHello extends StatefulWidget {
  const UserHello({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();

}

class _HomescreenState extends State<UserHello> {
  bool isActive = true;
  bool isBrigadeAccount = false;
  String greetingMessage = '';
  String userName = 'Usuario';
  String userRole = 'Usuario';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? names = prefs.getString('names') ?? 'Usuario';
    String? lastNames = prefs.getString('lastNames') ?? '';
    String? role = prefs.getString('roles') ?? 'Usuario';

    setState(() {
      userName = '$names $lastNames';
      userRole = role;
      greetingMessage = _getGreetingMessage();
      isBrigadeAccount = (role == 'brigade_accounts');
    });
  }

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buenos días';
    } else if (hour < 18) {
      return 'Buenas tardes';
    } else {
    }
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();

    return Container(
      alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greetingMessage,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 10),
            Text(
              userName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 10),
            Text(
              userRole,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurfaceVariant),
            ),
            //---------------------------------------------------------------------
            //---------------------------------------------------------------------
            //---------------------------------------------------------------------
            if (isBrigadeAccount)
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estado del brigadista',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isActive ? 'Activo' : 'Inactivo',
                        style: TextStyle(
                          fontSize: 16,
                          color: isActive ? Colors.red : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isActive = !isActive;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 134, 97, 83),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Actualizar estado',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
    );

  }
}