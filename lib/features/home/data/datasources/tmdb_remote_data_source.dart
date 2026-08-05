import 'package:dio/dio.dart';

import '../../../../core/config/app_env.dart';
import '../../../../core/network/tmdb_exception.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/movie_section_config.dart';
import '../models/movie_model.dart';

class TmdbRemoteDataSource {
  const TmdbRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<MovieModel>> fetchMovies(MovieSectionConfig config) async {
    if (!AppEnv.hasTmdbApiKey) {
      throw const TmdbException(
        'TMDB API key is missing. Add TMDB_API_KEY to .env and fully restart the app.',
      );
    }

    final response = await _dio.get<Map<String, dynamic>>(
      _endpointFor(config),
      queryParameters: _queryFor(config),
    );

    final results = (response.data?['results'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .where((json) => json['poster_path'] != null)
        .take(12)
        .toList();

    return [
      for (var index = 0; index < results.length; index++)
        MovieModel.fromJson(
          results[index],
          index,
          mediaType: config.source == MovieSectionSource.discoverTv
              ? 'tv'
              : null,
        ),
    ];
  }

  Future<List<MovieModel>> fetchMoviesByGenre({
    required int genreId,
    required int page,
  }) async {
    if (!AppEnv.hasTmdbApiKey) {
      throw const TmdbException(
        'TMDB API key is missing. Add TMDB_API_KEY to .env and fully restart the app.',
      );
    }

    final response = await _dio.get<Map<String, dynamic>>(
      '/discover/movie',
      queryParameters: {
        'page': page,
        'include_adult': false,
        'sort_by': 'popularity.desc',
        'with_genres': genreId,
      },
    );

    return _mapMovieResults(response.data, page: page, mediaType: 'movie');
  }

  Future<List<MovieModel>> fetchMoviesForVj({
    required String vjName,
    required int page,
  }) async {
    if (!AppEnv.hasTmdbApiKey) {
      throw const TmdbException(
        'TMDB API key is missing. Add TMDB_API_KEY to .env and fully restart the app.',
      );
    }

    final response = await _dio.get<Map<String, dynamic>>(
      '/trending/all/week',
      queryParameters: {'page': page, 'include_adult': false},
    );

    return _mapMovieResults(
      response.data,
      page: page,
      voiceLabel: vjName,
    ).take(18).toList();
  }

  Future<List<Genre>> fetchGenres() async {
    if (!AppEnv.hasTmdbApiKey) {
      throw const TmdbException(
        'TMDB API key is missing. Add TMDB_API_KEY to .env and fully restart the app.',
      );
    }

    final responses = await Future.wait([
      _dio.get<Map<String, dynamic>>('/genre/movie/list'),
      _dio.get<Map<String, dynamic>>('/genre/tv/list'),
    ]);

    final byId = <int, Genre>{};
    for (final response in responses) {
      final genres = response.data?['genres'] as List<dynamic>? ?? [];
      for (final item in genres.whereType<Map<String, dynamic>>()) {
        final id = (item['id'] as num?)?.toInt();
        final name = item['name'] as String?;
        if (id != null && name != null) {
          byId[id] = Genre(id: id, name: name);
        }
      }
    }

    final genres = byId.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return genres;
  }

  List<MovieModel> _mapMovieResults(
    Map<String, dynamic>? data, {
    required int page,
    String? mediaType,
    String? voiceLabel,
  }) {
    final results = (data?['results'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .where((json) => json['poster_path'] != null)
        .take(18)
        .toList();

    return [
      for (var index = 0; index < results.length; index++)
        MovieModel.fromJson(
          results[index],
          ((page - 1) * 20) + index,
          mediaType: mediaType,
          voiceLabel: voiceLabel,
        ),
    ];
  }

  String _endpointFor(MovieSectionConfig config) {
    return switch (config.source) {
      MovieSectionSource.trending => '/trending/all/week',
      MovieSectionSource.popular => '/movie/popular',
      MovieSectionSource.nowPlaying => '/movie/now_playing',
      MovieSectionSource.topRated => '/movie/top_rated',
      MovieSectionSource.discoverMovie => '/discover/movie',
      MovieSectionSource.discoverTv => '/discover/tv',
    };
  }

  Map<String, dynamic> _queryFor(MovieSectionConfig config) {
    return {
      'page': config.page,
      'include_adult': false,
      'sort_by': 'popularity.desc',
      if (config.genreId != null) 'with_genres': config.genreId,
      if (config.language != null) 'with_original_language': config.language,
    };
  }
}
