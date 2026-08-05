import 'movie.dart';

enum MovieSectionLayout { landscape, poster }

class MovieSection {
  const MovieSection({
    required this.title,
    required this.subtitle,
    required this.layout,
    required this.movies,
  });

  final String title;
  final String subtitle;
  final MovieSectionLayout layout;
  final List<Movie> movies;
}
