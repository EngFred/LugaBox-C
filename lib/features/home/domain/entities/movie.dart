class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.releaseYear,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voiceLabel,
  });

  final int id;
  final String title;
  final String releaseYear;
  final String posterUrl;
  final String backdropUrl;
  final String voiceLabel;
}
