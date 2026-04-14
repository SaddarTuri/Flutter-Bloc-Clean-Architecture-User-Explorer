import 'package:flutter/material.dart';
import 'package:user_explorer/core/constants/app_strings.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.hint = AppStrings.searchExplorersHint,
    this.controller,
    this.onChanged,
    this.enabled = true,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(22),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        enabled: enabled,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: colors.outline),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: colors.outline),
        ),
      ),
    );
  }
}
