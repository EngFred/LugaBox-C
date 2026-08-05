import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class GenreFilterRow extends StatelessWidget {
  const GenreFilterRow({super.key});

  static const _genres = ['ACTION', 'ADVENTURE', 'ANIMATION', 'CRIME'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 58,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            scrollDirection: Axis.horizontal,
            itemCount: _genres.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return Chip(
                label: Text(_genres[index]),
                backgroundColor: AppColors.field,
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 19,
                  vertical: 11,
                ),
                labelStyle: const TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 9),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 4, backgroundColor: Color(0xFF333333)),
            const SizedBox(width: 9),
            Container(
              width: 28,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
