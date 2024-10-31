import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCallBox extends StatelessWidget {
  const EmergencyCallBox({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Error al intentar realizar la llamada: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();

    return Card(
      color: basilTheme?.primaryContainer,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Línea segura UPB',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurface),
                  ),
                  Text(
                    '+57 300 422 23 21',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: basilTheme?.onSurface),
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () => _makePhoneCall('+573004222321'),
              style: ElevatedButton.styleFrom(
                backgroundColor: basilTheme?.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del Row al contenido
                children: [
                  const Icon(
                    Icons.phone_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8), // Espacio entre el icono y el texto
                  Text(
                    'Llamar',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xffffffff)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}