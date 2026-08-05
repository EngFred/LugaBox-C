import '../../domain/entities/movie_details.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../datasources/movie_details_remote_data_source.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  const MovieDetailsRepositoryImpl(this._remoteDataSource);

  final MovieDetailsRemoteDataSource _remoteDataSource;

  @override
  Future<MovieDetails> getDetails({
    required String mediaType,
    required int id,
  }) {
    return _remoteDataSource.fetchDetails(mediaType: mediaType, id: id);
  }
}
