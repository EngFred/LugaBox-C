import '../../domain/entities/movie_section.dart';
import '../../domain/entities/movie_section_config.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/tmdb_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  const MovieRepositoryImpl(this._remoteDataSource);

  final TmdbRemoteDataSource _remoteDataSource;

  @override
  Future<MovieSection> getSection(
    MovieSectionConfig config, {
    int? page,
  }) async {
    final pagedConfig = config.copyWith(page: page);
    final movies = await _remoteDataSource.fetchMovies(pagedConfig);

    return MovieSection(
      title: pagedConfig.title,
      subtitle: pagedConfig.subtitle,
      layout: pagedConfig.landscape
          ? MovieSectionLayout.landscape
          : MovieSectionLayout.poster,
      movies: movies,
      config: pagedConfig,
    );
  }

  @override
  Future<List<Genre>> getGenres() {
    return _remoteDataSource.fetchGenres();
  }

  @override
  Future<List<Movie>> getMoviesByGenre({
    required int genreId,
    required int page,
  }) {
    return _remoteDataSource.fetchMoviesByGenre(genreId: genreId, page: page);
  }

  @override
  Future<List<Movie>> getMoviesForVj({
    required String vjName,
    required int page,
  }) {
    return _remoteDataSource.fetchMoviesForVj(vjName: vjName, page: page);
  }
}
