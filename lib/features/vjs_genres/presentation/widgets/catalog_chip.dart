import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CatalogChip extends StatelessWidget {
  const CatalogChip({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onTap,
      label: Text(label),
      backgroundColor: AppColors.field,
      side: const BorderSide(color: AppColors.border),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      labelPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
      labelStyle: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
