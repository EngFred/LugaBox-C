class ApiConstants {
  const ApiConstants._();

  static const tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const tmdbImageBaseUrl = 'https://image.tmdb.org/t/p';

  static String posterUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$tmdbImageBaseUrl/w342$path';
  }

  static String backdropUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$tmdbImageBaseUrl/w780$path';
  }
}
