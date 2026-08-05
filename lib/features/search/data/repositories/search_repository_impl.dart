import '../../../home/data/datasources/tmdb_remote_data_source.dart';
import '../../../home/domain/entities/movie.dart';
import '../../domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(this._remoteDataSource);

  final TmdbRemoteDataSource _remoteDataSource;

  @override
  Future<List<Movie>> searchTitles({
    required String query,
    required String filter,
    required int page,
  }) {
    return _remoteDataSource.searchTitles(
      query: query,
      filter: filter,
      page: page,
    );
  }
}
