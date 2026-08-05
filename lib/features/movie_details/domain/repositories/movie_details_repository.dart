import '../entities/movie_details.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetails> getDetails({required String mediaType, required int id});
}
