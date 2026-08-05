import '../../../../core/network/api_constants.dart';
import '../../../home/data/models/movie_model.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/trailer.dart';
import 'credit_person_model.dart';

class MovieDetailsModel extends MovieDetails {
  MovieDetailsModel({
    required super.id,
    required super.mediaType,
    required super.title,
    required super.tagline,
    required super.overview,
    required super.releaseYear,
    required super.rating,
    required super.posterUrl,
    required super.backdropUrl,
    required super.voiceLabel,
    required super.runtimeLabel,
    required super.status,
    required super.production,
    required super.networks,
    required super.countries,
    required super.genres,
    required super.tags,
    required super.cast,
    required super.crew,
    required super.recommendations,
    required super.similarTitles,
    super.trailer,
    super.seasonName,
    super.seasonEpisodes,
  });

  factory MovieDetailsModel.fromJson(
    Map<String, dynamic> json,
    String mediaType,
  ) {
    final isTv = mediaType == 'tv';
    final title = (json[isTv ? 'name' : 'title'] ?? 'Untitled').toString();
    final date = (json[isTv ? 'first_air_date' : 'release_date'] ?? '')
        .toString();
    final season = (json['seasons'] as List<dynamic>?)
        ?.whereType<Map<String, dynamic>>()
        .where((item) => (item['season_number'] as num?)?.toInt() != 0)
        .firstOrNull;

    return MovieDetailsModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      mediaType: mediaType,
      title: title,
      tagline: (json['tagline'] ?? '').toString(),
      overview: (json['overview'] ?? '').toString(),
      releaseYear: date.length >= 4 ? date.substring(0, 4) : '',
      rating: ((json['vote_average'] as num?) ?? 0).toDouble(),
      posterUrl: ApiConstants.posterUrl(json['poster_path'] as String?),
      backdropUrl: ApiConstants.backdropUrl(json['backdrop_path'] as String?),
      voiceLabel: 'VJ NEIL',
      runtimeLabel: isTv
          ? '${(json['number_of_seasons'] as num?)?.toInt() ?? 1} Seasons'
          : _runtimeLabel((json['runtime'] as num?)?.toInt()),
      status: (json['status'] ?? 'Unknown').toString(),
      production: _names(json['production_companies']),
      networks: _names(json['networks']),
      countries: _countryNames(json['production_countries']),
      genres: _namesList(json['genres']),
      tags: _keywords(json),
      cast: _credits(
        json,
        'cast',
      ).map(CreditPersonModel.fromCastJson).take(16).toList(),
      crew: _credits(
        json,
        'crew',
      ).map(CreditPersonModel.fromCrewJson).take(16).toList(),
      trailer: _trailer(json),
      recommendations: _movieList(json, 'recommendations', mediaType),
      similarTitles: _movieList(json, 'similar', mediaType),
      seasonName: season?['name']?.toString(),
      seasonEpisodes: (season?['episode_count'] as num?)?.toInt(),
    );
  }

  static String _runtimeLabel(int? minutes) {
    if (minutes == null || minutes == 0) return 'Movie';
    final hours = minutes ~/ 60;
    final remaining = minutes % 60;
    if (hours == 0) return '${remaining}m';
    return '${hours}h ${remaining}m';
  }

  static List<Map<String, dynamic>> _credits(
    Map<String, dynamic> json,
    String key,
  ) {
    return ((json['credits'] as Map<String, dynamic>?)?[key]
                as List<dynamic>? ??
            [])
        .whereType<Map<String, dynamic>>()
        .where((item) => item['profile_path'] != null)
        .toList();
  }

  static List<String> _namesList(dynamic value) {
    return (value as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map((item) => (item['name'] ?? '').toString())
        .where((name) => name.isNotEmpty)
        .toList();
  }

  static String _names(dynamic value) {
    final names = _namesList(value);
    return names.isEmpty ? 'Not available' : names.take(3).join(', ');
  }

  static String _countryNames(dynamic value) {
    final countries = (value as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map((item) => (item['name'] ?? '').toString())
        .where((name) => name.isNotEmpty)
        .toList();
    return countries.isEmpty ? 'Not available' : countries.join(', ');
  }

  static List<String> _keywords(Map<String, dynamic> json) {
    final keywords = json['keywords'] as Map<String, dynamic>? ?? {};
    final list =
        (keywords['keywords'] ?? keywords['results']) as List<dynamic>? ?? [];
    return list
        .whereType<Map<String, dynamic>>()
        .map((item) => (item['name'] ?? '').toString())
        .where((name) => name.isNotEmpty)
        .take(18)
        .toList();
  }

  static Trailer? _trailer(Map<String, dynamic> json) {
    final videos =
        ((json['videos'] as Map<String, dynamic>?)?['results']
                    as List<dynamic>? ??
                [])
            .whereType<Map<String, dynamic>>();
    final trailer = videos.where((video) {
      return video['site'] == 'YouTube' &&
          (video['type'] == 'Trailer' || video['type'] == 'Teaser');
    }).firstOrNull;
    final key = trailer?['key'] as String?;
    if (key == null || key.isEmpty) return null;
    return Trailer(name: (trailer?['name'] ?? 'Trailer').toString(), key: key);
  }

  static List<MovieModel> _movieList(
    Map<String, dynamic> json,
    String key,
    String fallbackMediaType,
  ) {
    final results =
        ((json[key] as Map<String, dynamic>?)?['results'] as List<dynamic>? ??
                [])
            .whereType<Map<String, dynamic>>()
            .where((item) => item['poster_path'] != null)
            .take(12)
            .toList();
    return [
      for (var index = 0; index < results.length; index++)
        MovieModel.fromJson(
          results[index],
          index,
          mediaType: fallbackMediaType,
        ),
    ];
  }
}
