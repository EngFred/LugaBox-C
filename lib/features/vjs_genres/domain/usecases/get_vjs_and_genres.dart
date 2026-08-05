import '../../../../core/catalog/vj_catalog.dart';
import '../../../home/domain/entities/genre.dart';
import '../../../home/domain/repositories/movie_repository.dart';

class GetVjsAndGenres {
  const GetVjsAndGenres(this._repository);

  final MovieRepository _repository;

  Future<({List<String> vjs, List<Genre> genres})> call() async {
    final genres = await _repository.getGenres();
    return (vjs: VjCatalog.names, genres: genres);
  }
}
