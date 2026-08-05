import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/genre.dart';

class GenreFilterRow extends StatelessWidget {
  const GenreFilterRow({super.key, required this.genres, this.onGenreSelected});

  final List<Genre> genres;
  final void Function(Genre genre)? onGenreSelected;

  @override
  Widget build(BuildContext context) {
    final visibleGenres = genres.isEmpty
        ? const [
            Genre(id: 28, name: 'Action'),
            Genre(id: 12, name: 'Adventure'),
            Genre(id: 16, name: 'Animation'),
            Genre(id: 80, name: 'Crime'),
          ]
        : genres;

    return Column(
      children: [
        SizedBox(
          height: 58,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            scrollDirection: Axis.horizontal,
            itemCount: visibleGenres.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final genre = visibleGenres[index];
              return ActionChip(
                onPressed: () => onGenreSelected?.call(genre),
                label: Text(genre.name.toUpperCase()),
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
