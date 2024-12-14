import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.errorWidget,
    required this.onChanged,
    required this.initialValue,
    this.autoFocus = false,
    this.isDesc = false,
    this.capitalization = TextCapitalization.none,
  });

  final String hintText;
  final Widget? errorWidget;
  final Function(String) onChanged;
  final String? initialValue;
  final bool autoFocus;
  final bool isDesc;
  final TextCapitalization capitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: (value) => onChanged(value),
      autofocus: autoFocus,
      maxLines: isDesc ? 4 : null,
      textCapitalization: TextCapitalization.words,
      keyboardType: isDesc ? TextInputType.multiline : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.instance.dark25),
        error: errorWidget,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 13,
        ),
      ),
    );
  }
}
