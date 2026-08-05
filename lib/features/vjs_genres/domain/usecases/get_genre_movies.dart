import '../../../home/domain/entities/movie.dart';
import '../../../home/domain/repositories/movie_repository.dart';

class GetGenreMovies {
  const GetGenreMovies(this._repository);

  final MovieRepository _repository;

  Future<List<Movie>> call({required int genreId, required int page}) {
    return _repository.getMoviesByGenre(genreId: genreId, page: page);
  }
}
