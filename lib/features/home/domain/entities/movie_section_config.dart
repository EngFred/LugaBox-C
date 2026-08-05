enum MovieSectionSource {
  trending,
  popular,
  nowPlaying,
  topRated,
  discoverMovie,
  discoverTv,
}

class MovieSectionConfig {
  const MovieSectionConfig({
    required this.title,
    required this.subtitle,
    required this.source,
    this.genreId,
    this.language,
    this.page = 1,
    this.landscape = false,
  });

  final String title;
  final String subtitle;
  final MovieSectionSource source;
  final int? genreId;
  final String? language;
  final int page;
  final bool landscape;

  String get key => title.toLowerCase().replaceAll(' ', '_');

  MovieSectionConfig copyWith({int? page}) {
    return MovieSectionConfig(
      title: title,
      subtitle: subtitle,
      source: source,
      genreId: genreId,
      language: language,
      page: page ?? this.page,
      landscape: landscape,
    );
  }
}
