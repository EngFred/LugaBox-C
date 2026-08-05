import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/movie_section.dart';
import 'genre_filter_row.dart';
import 'movie_card.dart';
import 'movie_section_header.dart';

class MovieSectionList extends StatelessWidget {
  const MovieSectionList({
    super.key,
    required this.section,
    required this.showGenreFilters,
    required this.genres,
    required this.onLoadMore,
    required this.onGenreSelected,
  });

  final MovieSection section;
  final bool showGenreFilters;
  final List<Genre> genres;
  final VoidCallback onLoadMore;
  final void Function(Genre genre) onGenreSelected;

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
              GenreFilterRow(genres: genres, onGenreSelected: onGenreSelected),
              const SizedBox(height: 29),
            ],
            SizedBox(
              height: landscape ? 180 : 279,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  final metrics = notification.metrics;
                  if (metrics.pixels > metrics.maxScrollExtent - 460) {
                    onLoadMore();
                  }
                  return false;
                },
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  scrollDirection: Axis.horizontal,
                  itemCount: section.movies.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 13),
                  itemBuilder: (context, index) {
                    final movie = section.movies[index];
                    return MovieCard(
                      movie: movie,
                      landscape: landscape,
                      onTap: () {
                        context.push('/details/${movie.mediaType}/${movie.id}');
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
