import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/movie_details.dart';
import 'detail_chip.dart';
import 'details_back_button.dart';

class DetailsHero extends StatelessWidget {
  const DetailsHero({super.key, required this.details});

  final MovieDetails details;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          SizedBox(
            height: 500,
            width: double.infinity,
            child: Image.network(
              details.backdropUrl.isEmpty
                  ? details.posterUrl
                  : details.backdropUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const ColoredBox(color: AppColors.field),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: .05),
                    Colors.black.withValues(alpha: .35),
                    AppColors.black,
                  ],
                ),
              ),
            ),
          ),
          const Positioned(top: 18, left: 13, child: DetailsBackButton()),
          Positioned(
            left: 33,
            right: 33,
            bottom: 26,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details.title.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    height: .94,
                  ),
                ),
                if (details.tagline.isNotEmpty) ...[
                  const SizedBox(height: 23),
                  Text(
                    details.tagline,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFCFCFCF),
                      fontSize: 19,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
                const SizedBox(height: 21),
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFD54F),
                          size: 26,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          details.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    Text(details.releaseYear, style: _metaStyle),
                    const DetailChip(label: 'TV-14'),
                    DetailChip(label: details.voiceLabel, outlined: true),
                    Text(details.runtimeLabel, style: _metaStyle),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _metaStyle = TextStyle(
    color: Color(0xFFD0D0D0),
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );
}
