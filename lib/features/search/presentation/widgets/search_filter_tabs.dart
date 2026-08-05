import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SearchFilterTabs extends StatelessWidget {
  const SearchFilterTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  static const _filters = {'all': 'All', 'movie': 'Movies', 'tv': 'Series'};

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final entry in _filters.entries) ...[
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(entry.key),
              child: Container(
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected == entry.key
                      ? AppColors.red
                      : AppColors.field,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected == entry.key
                        ? AppColors.red
                        : AppColors.border,
                  ),
                ),
                child: Text(
                  entry.value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          if (entry.key != 'tv') const SizedBox(width: 10),
        ],
      ],
    );
  }
}
