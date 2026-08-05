import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class TagsSection extends StatelessWidget {
  const TagsSection({super.key, required this.genres, required this.tags});

  final List<String> genres;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final values = [...genres, ...tags].where((tag) => tag.isNotEmpty).toList();
    if (values.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(33, 0, 33, 58),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Genres & Tags',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 27),
            Wrap(
              spacing: 10,
              runSpacing: 14,
              children: [
                for (final value in values)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 19,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.field,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      value.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFFD8D8D8),
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
