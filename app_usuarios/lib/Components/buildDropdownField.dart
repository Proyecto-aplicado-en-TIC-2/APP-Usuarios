import 'package:appv2/Components/enums.dart';
import 'package:appv2/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class BuildDropdownField<T> extends StatefulWidget {
  final String topLabel;
  final String bottomHelperText;
  final List<T> items;
  final TextEditingController controller;

  const BuildDropdownField({
    Key? key,
    required this.topLabel,
    required this.bottomHelperText,
    required this.items,
    required this.controller,
  }) : super(key: key);

  @override
  _BuildDropdownFieldState<T> createState() => _BuildDropdownFieldState<T>();
}

class _BuildDropdownFieldState<T> extends State<BuildDropdownField<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.isNotEmpty ? widget.items[0] : null;
    widget.controller.text = selectedValue?.toString().split('.').last ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' ' + widget.topLabel,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: basilTheme?.onSurfaceVariant),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<T>(
          value: selectedValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: basilTheme?.surfaceContainer,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          ),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurfaceVariant),
          onChanged: (T? newValue) {
            setState(() {
              selectedValue = newValue;
              widget.controller.text = newValue?.toString().split('.').last ?? '';
            });
          },
          items: widget.items.map((T item) {
            final displayText = getDisplayName(item); // Usa getDisplayName para obtener el nombre personalizado
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                displayText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: basilTheme?.onSurfaceVariant)
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 5),
        Text(
          '   ' + widget.bottomHelperText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: basilTheme?.onSurfaceVariant),
        ),
      ],
    );
  }
}