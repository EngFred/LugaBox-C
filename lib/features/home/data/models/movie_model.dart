import '../../../../core/network/api_constants.dart';
import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.releaseYear,
    required super.posterUrl,
    required super.backdropUrl,
    required super.voiceLabel,
    required super.mediaType,
  });

  factory MovieModel.fromJson(
    Map<String, dynamic> json,
    int index, {
    String? mediaType,
  }) {
    final title = (json['title'] ?? json['name'] ?? 'Untitled').toString();
    final date = (json['release_date'] ?? json['first_air_date'] ?? '')
        .toString();
    final year = date.length >= 4 ? date.substring(0, 4) : '2026';

    return MovieModel(
      id: (json['id'] as num?)?.toInt() ?? index,
      title: title,
      releaseYear: year,
      posterUrl: ApiConstants.posterUrl(json['poster_path'] as String?),
      backdropUrl: ApiConstants.backdropUrl(json['backdrop_path'] as String?),
      voiceLabel: _vjLabels[index % _vjLabels.length],
      mediaType:
          mediaType ??
          (json['media_type'] as String?) ??
          (json['name'] != null ? 'tv' : 'movie'),
    );
  }

  static const _vjLabels = [
    'VJ SOUL',
    'VJ NEIL',
    'VJ JUNIOR',
    'VJ JINGO',
    'VJ MK',
    'VJ DAN DE',
    'VJ ICE P',
    'VJ WAZA',
  ];

  static String voiceLabelFor(int index) => _vjLabels[index % _vjLabels.length];
}
