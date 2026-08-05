class FeaturedTitle {
  const FeaturedTitle({
    required this.id,
    required this.mediaType,
    required this.title,
    required this.overview,
    required this.backdropUrl,
  });

  final int id;
  final String mediaType;
  final String title;
  final String overview;
  final String backdropUrl;
}
