import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../home/domain/entities/movie.dart';
import '../../../home/presentation/widgets/movie_card.dart';

class DiscoverTitleRow extends StatelessWidget {
  const DiscoverTitleRow({
    super.key,
    required this.title,
    required this.movies,
  });

  final String title;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 37),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              title,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 285,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (_, _) => const SizedBox(width: 21),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(
                  movie: movie,
                  landscape: false,
                  onTap: () =>
                      context.push('/details/${movie.mediaType}/${movie.id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
