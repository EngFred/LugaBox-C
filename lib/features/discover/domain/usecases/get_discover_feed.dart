import '../entities/discover_feed.dart';
import '../repositories/discover_repository.dart';

class GetDiscoverFeed {
  const GetDiscoverFeed(this._repository);

  final DiscoverRepository _repository;

  Future<DiscoverFeed> call() => _repository.getFeed();
}
