import 'movie.dart';
import 'movie_section_config.dart';

enum MovieSectionLayout { landscape, poster }

class MovieSection {
  const MovieSection({
    required this.title,
    required this.subtitle,
    required this.layout,
    required this.movies,
    required this.config,
  });

  final String title;
  final String subtitle;
  final MovieSectionLayout layout;
  final List<Movie> movies;
  final MovieSectionConfig config;
}
