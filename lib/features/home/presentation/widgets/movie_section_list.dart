import 'package:flutter/material.dart';

import '../../domain/entities/movie_section.dart';
import 'genre_filter_row.dart';
import 'movie_card.dart';
import 'movie_section_header.dart';

class MovieSectionList extends StatelessWidget {
  const MovieSectionList({
    super.key,
    required this.section,
    required this.showGenreFilters,
  });

  final MovieSection section;
  final bool showGenreFilters;

  @override
  Widget build(BuildContext context) {
    final landscape = section.layout == MovieSectionLayout.landscape;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 38),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieSectionHeader(
              title: section.title,
              subtitle: section.subtitle,
            ),
            if (showGenreFilters) ...[
              const GenreFilterRow(),
              const SizedBox(height: 29),
            ],
            SizedBox(
              height: landscape ? 180 : 279,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                scrollDirection: Axis.horizontal,
                itemCount: section.movies.length,
                separatorBuilder: (_, _) => const SizedBox(width: 13),
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: section.movies[index],
                    landscape: landscape,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
