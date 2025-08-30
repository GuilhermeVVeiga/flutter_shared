import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

typedef PercentChanged = void Function(num valor);

class InputPercentual extends StatefulWidget {
  const InputPercentual({
    super.key,
    required this.controller,
    required this.label,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.focusNode,
  });

  final TextEditingController controller;
  final String label;
  final bool enabled;
  final PercentChanged? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  @override
  State<InputPercentual> createState() => _InputPercentualState();
}

class _InputPercentualState extends State<InputPercentual> {
  final _formatter = CurrencyTextInputFormatter.currency(
    locale: 'pt_BR',
    symbol: '%',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();

    if (widget.controller.text.isEmpty) {
      widget.controller.text = _formatter.formatString('0');
    }
  }

  num _parseValue(String text) {
    final numericString = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (numericString.isEmpty) return 0;
    return num.parse(numericString) / 100;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [_formatter],
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: '% 0,00',
      ),
      validator: widget.validator,
      onChanged: (value) {
        widget.onChanged?.call(_parseValue(value));
      },
    );
  }
}
