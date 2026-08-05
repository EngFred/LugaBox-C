import '../../../home/domain/entities/movie.dart';
import '../repositories/search_repository.dart';

class SearchTitles {
  const SearchTitles(this._repository);

  final SearchRepository _repository;

  Future<List<Movie>> call({
    required String query,
    required String filter,
    required int page,
  }) {
    return _repository.searchTitles(query: query, filter: filter, page: page);
  }
}
