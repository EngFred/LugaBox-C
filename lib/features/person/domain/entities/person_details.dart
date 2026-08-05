import 'person_photo.dart';
import '../../../home/domain/entities/movie.dart';

class PersonDetails {
  const PersonDetails({
    required this.id,
    required this.name,
    required this.knownForDepartment,
    required this.birthday,
    required this.placeOfBirth,
    required this.biography,
    required this.profileUrl,
    required this.photos,
    required this.knownForTitles,
    this.imdbId,
    this.instagramId,
    this.facebookId,
  });

  final int id;
  final String name;
  final String knownForDepartment;
  final String birthday;
  final String placeOfBirth;
  final String biography;
  final String profileUrl;
  final List<PersonPhoto> photos;
  final List<Movie> knownForTitles;
  final String? imdbId;
  final String? instagramId;
  final String? facebookId;
}
