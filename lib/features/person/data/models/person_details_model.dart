import '../../../../core/network/api_constants.dart';
import '../../../home/data/models/movie_model.dart';
import '../../domain/entities/person_details.dart';
import '../../domain/entities/person_photo.dart';

class PersonDetailsModel extends PersonDetails {
  PersonDetailsModel({
    required super.id,
    required super.name,
    required super.knownForDepartment,
    required super.birthday,
    required super.placeOfBirth,
    required super.biography,
    required super.profileUrl,
    required super.photos,
    required super.knownForTitles,
    super.imdbId,
    super.instagramId,
    super.facebookId,
  });

  factory PersonDetailsModel.fromJson(Map<String, dynamic> json) {
    final externalIds = json['external_ids'] as Map<String, dynamic>? ?? {};
    final profiles =
        ((json['images'] as Map<String, dynamic>?)?['profiles']
                    as List<dynamic>? ??
                [])
            .whereType<Map<String, dynamic>>()
            .where((item) => item['file_path'] != null)
            .take(12)
            .map(
              (item) =>
                  PersonPhoto(url: ApiConstants.posterUrl(item['file_path'])),
            )
            .toList();

    return PersonDetailsModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? 'Unknown').toString(),
      knownForDepartment: (json['known_for_department'] ?? 'Acting').toString(),
      birthday: (json['birthday'] ?? 'Not available').toString(),
      placeOfBirth: (json['place_of_birth'] ?? 'Not available').toString(),
      biography: (json['biography'] ?? '').toString(),
      profileUrl: ApiConstants.posterUrl(json['profile_path'] as String?),
      photos: profiles,
      knownForTitles: _knownForTitles(json),
      imdbId: externalIds['imdb_id'] as String?,
      instagramId: externalIds['instagram_id'] as String?,
      facebookId: externalIds['facebook_id'] as String?,
    );
  }

  static List<MovieModel> _knownForTitles(Map<String, dynamic> json) {
    final cast =
        ((json['combined_credits'] as Map<String, dynamic>?)?['cast']
                    as List<dynamic>? ??
                [])
            .whereType<Map<String, dynamic>>()
            .where((item) => item['poster_path'] != null)
            .take(14)
            .toList();

    return [
      for (var index = 0; index < cast.length; index++)
        MovieModel.fromJson(cast[index], index),
    ];
  }
}
