import '../entities/movie_section.dart';
import '../entities/movie_section_config.dart';

abstract class MovieRepository {
  Future<MovieSection> getSection(MovieSectionConfig config);
}
