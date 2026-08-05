import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsBackButton extends StatelessWidget {
  const DetailsBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: context.pop,
      icon: const Icon(Icons.arrow_back, size: 30),
      style: IconButton.styleFrom(
        backgroundColor: Colors.black.withValues(alpha: .62),
        foregroundColor: Colors.white,
        fixedSize: const Size(54, 54),
      ),
    );
  }
}
