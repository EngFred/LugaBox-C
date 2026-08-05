import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class DetailChip extends StatelessWidget {
  const DetailChip({super.key, required this.label, this.outlined = false});

  final String label;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : AppColors.field,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: outlined ? AppColors.red : AppColors.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: outlined ? AppColors.red : AppColors.white,
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
