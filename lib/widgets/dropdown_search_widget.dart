import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AppDropdownSearch<T> extends StatelessWidget {
  const AppDropdownSearch({
    super.key,
    required this.items,
    this.itemAsString,
    required this.onChanged,
    this.selectedItem,
    this.validator,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.decoration, // <-- Adicionado aqui
    this.required = false,
    this.enabled = true,
  });

  final FutureOr<List<T>> Function(String? filter, LoadProps? props) items;
  final String Function(T)? itemAsString;
  final T? selectedItem;
  final String? Function(T?)? validator;
  final String? label;
  final String? hintText;
  final IconData? prefixIcon;
  final InputDecoration? decoration; // <-- Permitir personalizar
  final bool required;
  final bool enabled;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      items: items,
      selectedItem: selectedItem,
      itemAsString: itemAsString,
      enabled: enabled,
      onChanged: onChanged,
      validator:
          validator ??
          (required
              ? (value) => value == null ? 'Campo obrigatório' : null
              : null),
      compareFn: _defaultCompareFn,
      dropdownBuilder: (context, selectedItem) {
        if (selectedItem == null) return const Text('');
        return Text(
          itemAsString?.call(selectedItem) ?? selectedItem.toString(),
          maxLines: 1, // <- apenas UMA linha
          overflow: TextOverflow.ellipsis, // <- corta com ...
          style: Theme.of(context).textTheme.bodyMedium,
        );
      },
      popupProps: PopupProps.menu(
        showSelectedItems: true,
        showSearchBox: true,
        emptyBuilder:
            (context, searchEntry) => const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('Nenhuma opção encontrada.'),
              ),
            ),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: decoration ?? _buildDefaultDecoration(context),
      ),
    );
  }

  /// Se não passar decoração, usa a padrão
  InputDecoration _buildDefaultDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: label,
      hintText: hintText,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    );
  }

  bool _defaultCompareFn(T? a, T? b) {
    if (a == null || b == null) return false;
    return a == b;
  }
}
