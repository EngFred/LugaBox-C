import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back, size: 28),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.field,
        foregroundColor: AppColors.white,
        fixedSize: const Size(56, 56),
      ),
    );
  }
}
