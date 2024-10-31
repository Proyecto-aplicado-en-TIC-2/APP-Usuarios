import 'package:flutter/material.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:appv2/MiPerfil.dart';

class CustonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;


  const CustonAppbar({
    Key? key,
    required this.automaticallyImplyLeading
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
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
            const Spacer(),
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Define la altura del AppBar
}