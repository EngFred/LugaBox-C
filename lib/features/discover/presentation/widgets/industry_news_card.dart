import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class IndustryNewsCard extends StatelessWidget {
  const IndustryNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 31, 22, 40),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 30),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(19),
          boxShadow: [
            BoxShadow(
              color: AppColors.red.withValues(alpha: .23),
              blurRadius: 38,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.newspaper_rounded, size: 40, color: Colors.white),
            SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest Industry News',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Updates on movies, stars, and series.',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 34, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
