import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../home/domain/entities/movie.dart';

class TitleGridCard extends StatelessWidget {
  const TitleGridCard({super.key, required this.movie, required this.onTap});

  final Movie movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: AspectRatio(
              aspectRatio: .68,
              child: Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    const ColoredBox(color: AppColors.field),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            movie.releaseYear.isEmpty
                ? movie.voiceLabel
                : '${movie.releaseYear}  ›  ${movie.voiceLabel}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
