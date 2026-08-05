import '../../../home/domain/entities/movie.dart';
import 'credit_person.dart';
import 'trailer.dart';

class MovieDetails {
  const MovieDetails({
    required this.id,
    required this.mediaType,
    required this.title,
    required this.tagline,
    required this.overview,
    required this.releaseYear,
    required this.rating,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voiceLabel,
    required this.runtimeLabel,
    required this.status,
    required this.production,
    required this.networks,
    required this.countries,
    required this.genres,
    required this.tags,
    required this.cast,
    required this.crew,
    required this.recommendations,
    required this.similarTitles,
    this.trailer,
    this.seasonName,
    this.seasonEpisodes,
  });

  final int id;
  final String mediaType;
  final String title;
  final String tagline;
  final String overview;
  final String releaseYear;
  final double rating;
  final String posterUrl;
  final String backdropUrl;
  final String voiceLabel;
  final String runtimeLabel;
  final String status;
  final String production;
  final String networks;
  final String countries;
  final List<String> genres;
  final List<String> tags;
  final List<CreditPerson> cast;
  final List<CreditPerson> crew;
  final List<Movie> recommendations;
  final List<Movie> similarTitles;
  final Trailer? trailer;
  final String? seasonName;
  final int? seasonEpisodes;
}
