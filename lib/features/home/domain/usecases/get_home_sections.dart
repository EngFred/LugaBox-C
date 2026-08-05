import '../entities/movie_section.dart';
import '../entities/movie_section_config.dart';
import '../repositories/movie_repository.dart';

class GetHomeSections {
  const GetHomeSections(this._repository);

  final MovieRepository _repository;

  Future<List<MovieSection>> call() async {
    final sections = await Future.wait(
      configs.map(_repository.getSection),
      eagerError: true,
    );

    return sections.where((section) => section.movies.isNotEmpty).toList();
  }

  Future<MovieSection> sectionPage(MovieSectionConfig config, int page) {
    return _repository.getSection(config, page: page);
  }

  static const configs = [
    MovieSectionConfig(
      title: 'Trending',
      subtitle: 'Popular picks across LugaBox',
      source: MovieSectionSource.trending,
      landscape: true,
    ),
    MovieSectionConfig(
      title: 'Chinese series',
      subtitle: 'Epic stories from China',
      source: MovieSectionSource.discoverTv,
      language: 'zh',
      landscape: true,
    ),
    MovieSectionConfig(
      title: 'Special Collection',
      subtitle: 'Special picks worth watching',
      source: MovieSectionSource.topRated,
      page: 2,
    ),
    MovieSectionConfig(
      title: 'Browse by Genres',
      subtitle: 'Find something for your mood',
      source: MovieSectionSource.popular,
    ),
    MovieSectionConfig(
      title: 'Latest on LugaBox',
      subtitle: 'Fresh movies and series just added for you',
      source: MovieSectionSource.nowPlaying,
    ),
    MovieSectionConfig(
      title: 'Latest uploads',
      subtitle: 'Recently added movies and series',
      source: MovieSectionSource.popular,
      page: 2,
    ),
    MovieSectionConfig(
      title: 'Mini Series',
      subtitle: 'Short stories with unforgettable moments',
      source: MovieSectionSource.discoverTv,
      page: 2,
      landscape: true,
    ),
    MovieSectionConfig(
      title: 'Drama',
      subtitle: 'Powerful stories that keep you hooked',
      source: MovieSectionSource.discoverMovie,
      genreId: 18,
    ),
    MovieSectionConfig(
      title: 'Action',
      subtitle: 'Action-packed entertainment awaits',
      source: MovieSectionSource.discoverMovie,
      genreId: 28,
    ),
    MovieSectionConfig(
      title: 'Comedy',
      subtitle: 'Fun stories to brighten your day',
      source: MovieSectionSource.discoverMovie,
      genreId: 35,
    ),
    MovieSectionConfig(
      title: 'Sci Fi',
      subtitle: 'Where science meets imagination',
      source: MovieSectionSource.discoverMovie,
      genreId: 878,
    ),
    MovieSectionConfig(
      title: 'Romance',
      subtitle: 'Love stories that capture the heart',
      source: MovieSectionSource.discoverMovie,
      genreId: 10749,
    ),
    MovieSectionConfig(
      title: 'Adventure',
      subtitle: 'From hidden treasures to epic battles',
      source: MovieSectionSource.discoverMovie,
      genreId: 12,
    ),
    MovieSectionConfig(
      title: 'Horror',
      subtitle: 'Terrifying stories that will keep you up',
      source: MovieSectionSource.discoverMovie,
      genreId: 27,
    ),
    MovieSectionConfig(
      title: 'Korean',
      subtitle: 'The best Korean dramas and movies',
      source: MovieSectionSource.discoverTv,
      language: 'ko',
      landscape: true,
    ),
    MovieSectionConfig(
      title: 'Indian',
      subtitle: 'Blockbusters and dramas from India',
      source: MovieSectionSource.discoverMovie,
      language: 'hi',
    ),
    MovieSectionConfig(
      title: 'Fantasy',
      subtitle: 'Step into worlds beyond imagination',
      source: MovieSectionSource.discoverMovie,
      genreId: 14,
    ),
    MovieSectionConfig(
      title: 'Animation',
      subtitle: 'Animated adventures for all ages',
      source: MovieSectionSource.discoverMovie,
      genreId: 16,
    ),
  ];
}
