import '../entities/genre.dart';
import '../repositories/movie_repository.dart';

class GetGenres {
  const GetGenres(this._repository);

  final MovieRepository _repository;

  Future<List<Genre>> call() => _repository.getGenres();
}
