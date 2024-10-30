import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/MiPerfil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: basilTheme?.surface,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'UPB Segura',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: basilTheme?.onSurface),
                ),
                Spacer(), // Espacio entre el título y el icono
                IconButton(
                  icon: const Icon(Icons.account_circle_rounded),
                  color: basilTheme?.onSurface,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MiPerfilScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
  }
}