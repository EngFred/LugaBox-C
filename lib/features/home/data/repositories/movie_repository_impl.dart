import '../../domain/entities/movie_section.dart';
import '../../domain/entities/movie_section_config.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/tmdb_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  const MovieRepositoryImpl(this._remoteDataSource);

  final TmdbRemoteDataSource _remoteDataSource;

  @override
  Future<MovieSection> getSection(MovieSectionConfig config) async {
    final movies = await _remoteDataSource.fetchMovies(config);

    return MovieSection(
      title: config.title,
      subtitle: config.subtitle,
      layout: config.landscape
          ? MovieSectionLayout.landscape
          : MovieSectionLayout.poster,
      movies: movies,
    );
  }
}
