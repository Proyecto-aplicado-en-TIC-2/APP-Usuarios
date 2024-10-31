import 'package:flutter/material.dart';

class EmergencyCard extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color textColor;
  final double iconSize; // Tamaño del icono

  const EmergencyCard({
    super.key,
    required this.color,
    required this.title,
    required this.description,
    required this.onTap,
    required this.textColor,
    this.iconSize = 20, // Tamaño predeterminado del icono
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: textColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: textColor),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_sharp,
                color: textColor,
                size: iconSize, // Tamaño del icono
              ),
            ],
          ),
        ),
      ),
    );
  }
}