import '../entities/genre.dart';
import '../entities/movie.dart';
import '../entities/movie_section.dart';
import '../entities/movie_section_config.dart';

abstract class MovieRepository {
  Future<MovieSection> getSection(MovieSectionConfig config, {int? page});

  Future<List<Genre>> getGenres();

  Future<List<Movie>> getMoviesByGenre({
    required int genreId,
    required int page,
  });

  Future<List<Movie>> getMoviesForVj({
    required String vjName,
    required int page,
  });
}
