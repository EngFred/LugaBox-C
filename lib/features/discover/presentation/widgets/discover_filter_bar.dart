import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class DiscoverFilterBar extends StatelessWidget {
  const DiscoverFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    const filters = ['Everything', 'Movies', 'Series', 'Today', 'This week'];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, index) =>
            index == 2 ? const _DividerGap() : const SizedBox(width: 9),
        itemBuilder: (context, index) {
          final selected = index == 0 || index == 4;
          return Chip(
            label: Text(filters[index]),
            backgroundColor: selected ? AppColors.red : AppColors.field,
            side: BorderSide(
              color: selected ? AppColors.red : AppColors.border,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            labelPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 7,
            ),
            labelStyle: const TextStyle(
              color: AppColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          );
        },
      ),
    );
  }
}

class _DividerGap extends StatelessWidget {
  const _DividerGap();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 9),
        Container(width: 1, height: 26, color: AppColors.border),
        const SizedBox(width: 9),
      ],
    );
  }
}
