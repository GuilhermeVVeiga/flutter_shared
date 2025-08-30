import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData? icon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obrigatorio;
  final int? maxLength;
  final int? maxLines; 
  final int? minLines;

  const InputText({
    super.key,
    this.controller,
    required this.label,
    this.icon,
    this.suffixIcon,
    this.validator,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.obrigatorio = false,
    this.maxLength,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    final labelText = obrigatorio ? '$label (*)' : label;

    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator:
          validator ??
          (obrigatorio
              ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo é obrigatório';
                }
                return null;
              }
              : null),
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: suffixIcon,
        labelText: labelText,
        fillColor: Colors.white,
      ),
    );
  }
}
