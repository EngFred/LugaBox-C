import '../../../home/domain/entities/movie.dart';
import 'discover_person.dart';
import 'featured_title.dart';

class DiscoverFeed {
  const DiscoverFeed({
    required this.featured,
    required this.trendingNow,
    required this.airingToday,
    required this.popularMovies,
    required this.popularSeries,
    required this.trendingPeople,
    required this.topRatedMovies,
    required this.topRatedSeries,
    required this.popularPeople,
    required this.comingSoon,
  });

  final List<FeaturedTitle> featured;
  final List<Movie> trendingNow;
  final List<Movie> airingToday;
  final List<Movie> popularMovies;
  final List<Movie> popularSeries;
  final List<DiscoverPerson> trendingPeople;
  final List<Movie> topRatedMovies;
  final List<Movie> topRatedSeries;
  final List<DiscoverPerson> popularPeople;
  final List<Movie> comingSoon;
}
