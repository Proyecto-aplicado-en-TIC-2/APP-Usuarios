import 'package:appv2/Components/CallButton.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCallBox extends StatelessWidget {
  const EmergencyCallBox({super.key});

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
           const CallButton(phone: '3004222321'),
          ],
        ),
      ),
    );
  }
}