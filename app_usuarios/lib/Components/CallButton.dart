import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  final String phone;

  const CallButton({
    Key? key,
    required this.phone,
  }) : super(key: key);

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
    return FilledButton(
      onPressed: () => _makePhoneCall(phone),
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
    );
  }
}