import '../../../home/domain/entities/movie.dart';
import '../../../home/domain/repositories/movie_repository.dart';

class GetVjMovies {
  const GetVjMovies(this._repository);

  final MovieRepository _repository;

  Future<List<Movie>> call({required String vjName, required int page}) {
    return _repository.getMoviesForVj(vjName: vjName, page: page);
  }
}
