import '../entities/discover_feed.dart';

abstract class DiscoverRepository {
  Future<DiscoverFeed> getFeed();
}
