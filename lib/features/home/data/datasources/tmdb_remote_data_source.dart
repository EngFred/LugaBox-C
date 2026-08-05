import 'package:dio/dio.dart';

import '../../../../core/config/app_env.dart';
import '../../domain/entities/movie_section_config.dart';
import '../models/movie_model.dart';

class TmdbRemoteDataSource {
  const TmdbRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<MovieModel>> fetchMovies(MovieSectionConfig config) async {
    if (!AppEnv.hasTmdbApiKey) {
      return _fallbackMovies(config);
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
        MovieModel.fromJson(results[index], index),
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

  List<MovieModel> _fallbackMovies(MovieSectionConfig config) {
    const posters = [
      '/xNPU7zLz5Wfb0Xywwoln2nWri9Z.jpg',
      '/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      '/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
      '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
      '/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg',
      '/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
    ];
    const backdrops = [
      '/9BBTo63ANSmhC4e6r62OJFuK2GL.jpg',
      '/nMKdUUepR0i5zn0y1T4CsSB5chy.jpg',
      '/s16H6tpK2utvwDtzZ8Qy4qm5Emw.jpg',
      '/xJHokMbljvjADYdit5fK5VQsXEG.jpg',
      '/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
      '/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg',
    ];

    return List.generate(10, (index) {
      final title =
          _fallbackTitles[(index + config.title.length) %
              _fallbackTitles.length];
      return MovieModel(
        id: index,
        title: title,
        releaseYear: '${2026 - (index % 12)}',
        posterUrl:
            'https://image.tmdb.org/t/p/w342${posters[index % posters.length]}',
        backdropUrl:
            'https://image.tmdb.org/t/p/w780${backdrops[index % backdrops.length]}',
        voiceLabel: MovieModel.voiceLabelFor(index),
      );
    });
  }

  static const _fallbackTitles = [
    'Moon Knight',
    'Spider-Man: Brand New Day',
    'Leviticus',
    'Lucky',
    'Krypton',
    'The Roundup: Punishment',
    'Rambo: First Blood',
    'Harry Potter and the Deathly Hallows',
    'Everyone Loves Me',
    'Go Go Squid!',
  ];
}
