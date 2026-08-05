import '../entities/movie_details.dart';
import '../repositories/movie_details_repository.dart';

class GetMovieDetails {
  const GetMovieDetails(this._repository);

  final MovieDetailsRepository _repository;

  Future<MovieDetails> call({required String mediaType, required int id}) {
    return _repository.getDetails(mediaType: mediaType, id: id);
  }
}
