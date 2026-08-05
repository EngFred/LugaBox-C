import '../../../home/data/datasources/tmdb_remote_data_source.dart';
import '../../domain/entities/discover_feed.dart';
import '../../domain/repositories/discover_repository.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  const DiscoverRepositoryImpl(this._remoteDataSource);

  final TmdbRemoteDataSource _remoteDataSource;

  @override
  Future<DiscoverFeed> getFeed() async {
    final results = await Future.wait([
      _remoteDataSource.fetchFeaturedTitles(),
      _remoteDataSource.fetchList(endpoint: '/trending/all/week', page: 1),
      _remoteDataSource.fetchList(
        endpoint: '/tv/airing_today',
        page: 1,
        mediaType: 'tv',
      ),
      _remoteDataSource.fetchList(
        endpoint: '/movie/popular',
        page: 1,
        mediaType: 'movie',
      ),
      _remoteDataSource.fetchList(
        endpoint: '/tv/popular',
        page: 1,
        mediaType: 'tv',
      ),
      _remoteDataSource.fetchPeople('/trending/person/week'),
      _remoteDataSource.fetchList(
        endpoint: '/movie/top_rated',
        page: 1,
        mediaType: 'movie',
      ),
      _remoteDataSource.fetchList(
        endpoint: '/tv/top_rated',
        page: 1,
        mediaType: 'tv',
      ),
      _remoteDataSource.fetchPeople('/person/popular'),
      _remoteDataSource.fetchList(
        endpoint: '/movie/upcoming',
        page: 1,
        mediaType: 'movie',
      ),
    ]);

    return DiscoverFeed(
      featured: results[0].cast(),
      trendingNow: results[1].cast(),
      airingToday: results[2].cast(),
      popularMovies: results[3].cast(),
      popularSeries: results[4].cast(),
      trendingPeople: results[5].cast(),
      topRatedMovies: results[6].cast(),
      topRatedSeries: results[7].cast(),
      popularPeople: results[8].cast(),
      comingSoon: results[9].cast(),
    );
  }
}
