import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../home/domain/entities/movie.dart';
import '../../../home/presentation/widgets/movie_card.dart';

class DetailsMovieRow extends StatelessWidget {
  const DetailsMovieRow({super.key, required this.title, required this.movies});

  final String title;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 21),
            SizedBox(
              height: 279,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                separatorBuilder: (_, _) => const SizedBox(width: 13),
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
      ),
    );
  }
}
