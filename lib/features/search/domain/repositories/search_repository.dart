import '../../../home/domain/entities/movie.dart';

abstract class SearchRepository {
  Future<List<Movie>> searchTitles({
    required String query,
    required String filter,
    required int page,
  });
}
